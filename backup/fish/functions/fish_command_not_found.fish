### Command-not-found handlers
# This can be overridden by defining a new fish_command_not_found function

# Read the OS/Distro from /etc/os-release.
# This has a "ID=" line that defines the exact distribution,
# and an "ID_LIKE=" line that defines what it is derived from or otherwise like.
# For our purposes, we use both.
set -l os
if test -r /etc/os-release
    set os (string match -r '^ID(?:_LIKE)?\s*=.*' < /etc/os-release | \
    string replace -r '^ID(?:_LIKE)?\s*=(.*)' '$1' | string trim -c '\'"' | string split " ")
end

# Use standard fish command not found handler otherwise
function fish_command_not_found --on-event fish_command_not_found
	__fish_default_command_not_found_handler $argv
end
