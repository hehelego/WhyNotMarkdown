import vim
import os
def py_log(log):
	vim.command(f"echo '[PLUG_LOADER] {log}'")

def load_plugin_configs():
	conf_dir=os.path.expandvars(r'$HOME/.config/nvim/plugin_config')
	loading = None
	try:
		confs = sorted(os.listdir(conf_dir))
		for x in confs:
			path = os.path.join(conf_dir,x)
			loading = path
			vim.command('source {}'.format(path))
			loading = None
	except Exception as e:
		py_log('FAILED:: {}'.format(loading))
		py_log('FAILED:: {}'.format(str(e)))
	else:
		py_log('SUCCESS:: all plugin config files loaded')


if __name__=='__main__':
	load_plugin_configs()
