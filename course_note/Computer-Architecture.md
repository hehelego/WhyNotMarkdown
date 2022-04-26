# Note on Computer Architecture

> - [ShanghaiTech CS110](https://robotics.shanghaitech.edu.cn/courses/ca/22s)
> - [UC Berkeley CS61C](https://cs61c.org/su20/)

## cache: part 1

### Fully Associative

> organize all the cache lines in one set
> need cache eviction algorithm
> inefficient in lookup, efficient in space(every cache line/block will be used)

```python
# log2 of the Memory Address space
ADDRESS_BITS = 32

# log2 of the block/line size
OFFSET_BITS = 4
# put BLOCK_SIZE bytes in one block/line
BLOCK_SIZE = 1 << OFFSET_BITS

# in FA cache, the rest of the address bits are used as tag to identify memory block/line
TAG_BITS = ADDRESS_BITS - OFFSET_BITS

# number of blocks/lines in the cache
CACHE_SIZE = 1 << 16


class FixedWidth:
    def __init__(self, width: int, raw: int = 0) -> None:
        self.width = width
        self.mask = (1 << width)-1
        self.raw = raw & self.mask

    def as_int(self) -> int:
        return self.raw

    def as_list(self) -> list[int]:
        return [(self.raw >> i) & 1for i in range(self.width)]

    def __eq__(self, rhs: object) -> bool:
        if isinstance(rhs, FixedWidth):
            return self.width == rhs.width and self.raw == rhs.raw
        if isinstance(rhs, int):
            return self.raw == rhs
        return False


def list_to_int(l: list[int]) -> int:
    return sum(v << i for (i, v) in enumerate(l))


class ByteData:
    def __init__(self, raw: int = 0) -> None:
        self.data = FixedWidth(width=32, raw=raw)


class CacheLine:
    def __init__(self) -> None:
        self.valid = False
        self.tag = FixedWidth(width=TAG_BITS)
        self.data = [ByteData() for _ in range(BLOCK_SIZE)]


class FA:
    def __init__(self) -> None:
        self.slots = [CacheLine() for _ in range(CACHE_SIZE)]

    def split_addr(self, addr: FixedWidth) -> tuple[FixedWidth, FixedWidth]:
        assert addr.width == ADDRESS_BITS
        #  addr[:OFFSET_BITS], addr[OFFSET_BITS:]
        addr_bits = addr.as_list()
        offset = list_to_int(addr_bits[:OFFSET_BITS])
        tag = list_to_int(addr_bits[OFFSET_BITS:])
        return (FixedWidth(offset, OFFSET_BITS), FixedWidth(tag, TAG_BITS))

    def try_get(self, addr: FixedWidth) -> ByteData | None:
        offset, tag = self.split_addr(addr)

        for slot in self.slots:
            if slot.valid and slot.tag == tag:
                # hit
                return slot.data[offset.as_int()]

        # missed
        return None
```

### Direct Mapped

> each cache line corresponds to a single-element set
> no need for and cannot implement any cache eviction algorithm
> efficient in lookup, inefficient in space(may not use every cache line/block, the worst case: only using single slot)

```python
# log2 of the Memory Address space
ADDRESS_BITS = 32

# log2 of the block/line size
OFFSET_BITS = 4
# put BLOCK_SIZE bytes in one block/line
BLOCK_SIZE = 1 << OFFSET_BITS

# log2 of sets
INDEX_BITS = 4
# devide the cache blocks/lines into SET_NUM sets
SET_NUM = 1 << INDEX_BITS

# the rest of the address bits are used as tag to identify memory block/line
TAG_BITS = ADDRESS_BITS - OFFSET_BITS

# number of blocks/lines in the cache
CACHE_SIZE = 1 << 16


class FixedWidth:
    def __init__(self, width: int, raw: int = 0) -> None:
        self.width = width
        self.mask = (1 << width)-1
        self.raw = raw & self.mask

    def as_int(self) -> int:
        return self.raw

    def as_list(self) -> list[int]:
        return [(self.raw >> i) & 1for i in range(self.width)]

    def __eq__(self, rhs: object) -> bool:
        if isinstance(rhs, FixedWidth):
            return self.width == rhs.width and self.raw == rhs.raw
        if isinstance(rhs, int):
            return self.raw == rhs
        return False


def list_to_int(l: list[int]) -> int:
    return sum(v << i for (i, v) in enumerate(l))


class ByteData:
    def __init__(self, raw: int = 0) -> None:
        self.data = FixedWidth(width=32, raw=raw)


class CacheLine:
    def __init__(self) -> None:
        self.valid = False
        self.tag = FixedWidth(width=TAG_BITS)
        self.data = [ByteData() for _ in range(BLOCK_SIZE)]


class DM:
    def __init__(self) -> None:
        self.slots = [CacheLine() for _ in range(SET_NUM)]

    def split_addr(self, addr: FixedWidth) -> tuple[FixedWidth, FixedWidth, FixedWidth]:
        assert addr.width == ADDRESS_BITS
        # (tag,index,offset) <- addr_bits
        addr_bits = addr.as_list()
        offset = list_to_int(addr_bits[:OFFSET_BITS])
        index = list_to_int(addr_bits[OFFSET_BITS:OFFSET_BITS+INDEX_BITS])
        tag = list_to_int(addr_bits[OFFSET_BITS+INDEX_BITS:])
        return (FixedWidth(offset, OFFSET_BITS), FixedWidth(index, INDEX_BITS), FixedWidth(tag, TAG_BITS))

    def try_get(self, addr: FixedWidth) -> ByteData | None:
        offset, index, tag = self.split_addr(addr)

        slot = self.slots[index.as_int()]
        # test for hit
        if slot.valid and slot.tag == tag:
            return slot.data[offset.as_int()]

        # missed
        return None
```

### Set Associative

> combination of fully-associative and direct-mapped, strike the balance
>
> - In Total `M` cache lines/blocks
> - Divides them into sets of size `N` (this is called an N-way set associative cache)
> - Each set hold `M/N` cache lines/blocks which are organized as a fully-associative cache.
>
> Fully-Associative cache can be seen as an M-way set associative cache (N=M)
> Direct-Mapped cache can be regarded as a one-way set associative cache (N=1)

Analogy: N-way set associative cache is similar to a chaining hash table where N elements are allowed in each slot.

## cache: part2

### cache performance (rough) modeling

- Hit Rate: proportion of the accesses that hit in cache
- Hit Time: the time we needed to retrieve data when we hit the cache
- Miss Time: Hit-Time + Miss-Penalty (the time to search in cache and the time to go into memory)

Average Memory Access Time (AMAT): The Hit-Time plus the product of the Miss-Rate and the Miss-Penalty

```plaintext
AMAT
= HR * HT + MR * MT
= HR * HT + MR * (HT + MP)
= (HR + MR) * HT + MR * MP
= HT + MR * MP
```

### impact of each parameter

- generally speaking: larger cache size, higher hit time, lower miss rate
- Associativity: higher associativity, higher hit time (more time for comparison)

### categorization of cache misses

- Compulsory: On cold start, the first time we access any cache line.  
  (Increase cache line size; However, larger cache line result in higher memory transfer time in Miss-Penalty)
- Capacity: No enough space to store all blocks that will be accessed even for FA.  
  (Increase cache size)
- Conflict/Collision: Too many accessed memory addresses are mapped to the same cache location.  
  (Increase associativity to reduce collision)

### multi-level cache hierarchy

- L1: minimize the hit time
- L2/L3: lower the miss rate

## cache: part3

### read/write policy for consistency

### protocol for multiprocessor cache coherence

**TODO:** the MSI/MOESI protocol
