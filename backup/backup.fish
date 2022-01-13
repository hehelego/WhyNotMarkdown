#!/usr/bin/fish
# wrapper around rsync
function backup
	if test (count $argv) -ge 2
		echo 'BACKUP' $argv | tee -a  backup.log.script
		rsync -azcvhP --delete $argv[1] $argv[2] >> backup.log.rsync
	else
		echo 'SKIP' $argv | tee -a backup.log.script
		return
	end
end
function backup_setup
	cat /dev/null > backup.log.script
	cat /dev/null > backup.log.rsync
	echo "backup start at "(date) | tee -a backup.log.script
end
function backup_finish
	echo "backup ended at"(date) | tee -a backup.log.script
end

# start
backup_setup




backup ~/.ssh/config                                 ~/.workspace/git-repo/WhyNotMarkdown/backup/ssh.conf
backup ~/.tmux.conf                                  ~/.workspace/git-repo/WhyNotMarkdown/backup/tmux.conf
backup ~/.config/systemd/                            ~/.workspace/git-repo/WhyNotMarkdown/backup/systemd/
backup ~/.config/environment.d/                      ~/.workspace/git-repo/WhyNotMarkdown/backup/environment.d/
backup ~/.config/i3/                                 ~/.workspace/git-repo/WhyNotMarkdown/backup/i3_conf/i3_conf/
backup ~/.config/sway/                               ~/.workspace/git-repo/WhyNotMarkdown/backup/i3_conf/sway/
backup ~/.config/i3status-rust/                      ~/.workspace/git-repo/WhyNotMarkdown/backup/i3_conf/i3status-rust/
backup ~/.config/dunst/                              ~/.workspace/git-repo/WhyNotMarkdown/backup/i3_conf/dunst/
backup ~/.config/fish/                               ~/.workspace/git-repo/WhyNotMarkdown/backup/fish/
backup ~/.config/starship/                           ~/.workspace/git-repo/WhyNotMarkdown/backup/starship/
backup ~/.config/nvim/                               ~/.workspace/git-repo/WhyNotMarkdown/backup/nvim/
backup ~/.config/alacritty/                          ~/.workspace/git-repo/WhyNotMarkdown/backup/alacritty/
backup ~/.config/rofi/                               ~/.workspace/git-repo/WhyNotMarkdown/backup/rofi/
backup ~/.config/keynav/                             ~/.workspace/git-repo/WhyNotMarkdown/backup/keynav/
backup ~/.config/qutebrowser/                        ~/.workspace/git-repo/WhyNotMarkdown/backup/qutebrowser/
backup ~/.config/fontconfig/fonts.conf               ~/.workspace/git-repo/WhyNotMarkdown/backup/font.conf
backup ~/.workspace/firefox-bookmarks.json           ~/.workspace/git-repo/WhyNotMarkdown/backup/FF_bookmarks.json
backup ~/.workspace/backup.fish                      ~/.workspace/git-repo/WhyNotMarkdown/backup/backup.fish



backup ~/.workspace/Passwords.kdbx                   ~/.workspace/BACKUP/Passwords.kdbx
backup ~/.workspace/kee-file                         ~/.workspace/BACKUP/kee-file
backup ~/.workspace/thunderbird-calendar.ics         ~/.workspace/BACKUP/thunderbird-calendar.ics
backup ~/.workspace/firefox-bookmarks.json           ~/.workspace/BACKUP/firefox-bookmarks.json
backup ~/.workspace/backup.fish                      ~/.workspace/BACKUP/backup.fish

backup ~/SHTU/                                       ~/.workspace/BACKUP/SHTU/
backup ~/SOUND/                                      ~/.workspace/BACKUP/SOUND/
backup ~/.workspace/git-repo/                        ~/.workspace/BACKUP/git-repo
backup ~/.workspace/resources/                       ~/.workspace/BACKUP/resources/




# end
backup_finish
