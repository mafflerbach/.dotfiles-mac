nord = {
    # Polar Night
    'nord0': '#2e3440',
    'nord1': '#3b4252',
    'nord2': '#434c5e',
    'nord3': '#4c566a',
    # Snow Storm
    'nord4': '#d8dee9',
    'nord5': '#e5e9f0',
    'nord6': '#eceff4',
    # Frost
    'nord7': '#8fbcbb',
    'nord8': '#88c0d0',
    'nord9': '#81a1c1',
    'nord10': '#5e81ac',
    # Aurora
    'nord11': '#bf616a',
    'nord12': '#d08770',
    'nord13': '#ebcb8b',
    'nord14': '#a3be8c',
    'nord15': '#b48ead',
    }



# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
config.load_autoconfig()

config.set('content.javascript.enabled', True, 'file://*')
config.set('fonts.default_family' ,  ["Inconsolata-dz for Powerline", "Monospace", "DejaVu Sans Mono", "Monaco", "Bitstream Vera Sans Mono", "Andale Mono", "Courier New", "Courier", "Liberation Mono", "monospace", "Fixed", "Consolas", "Terminal", "JetBrains Mono NL Regular"])
config.set('fonts.default_size' , '12pt')
# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.can_access_clipboard', True)
config.set('window.transparent', True)

config.set('url.searchengines',{"d": "https://duckduckgo.com/?q={}", "DEFAULT": "https://www.google.com/search?q={}"})


# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

config.bind('<Ctrl-Shift-y>', 'hint links spawn --verbose --detach /home/maren/dotfiles/i3/script/playYtOnClient.sh "{hint-url}" ')

config.bind('<Ctrl-Shift-p>', 'hint links spawn --verbose --detach /home/maren/dotfiles/i3/script/fillplaylist.sh push {hint-url}')

config.bind('<Ctrl-Shift-o>', 'spawn --verbose --detach /home/maren/dotfiles/i3/script/fillplaylist.sh play')

config.bind('<Ctrl-Shift-l>', 'hint links spawn --verbose --detach  youtube-dl {hint-url} --output /home/maren/Downloads/ytFiles/%(title)s.%(ext)s')

config.bind('<Ctrl-Shift-f>', 'hint links spawn --verbose --detach  /opt/nzb-monkey/nzbmonkey.py "{hint-url}" ')


config.bind('<Ctrl-Shift-d>', 'hint links spawn --verbose --detach mpv {hint-url} --input-ipc-server=/tmp/mpvsocket')

config.set('content.headers.user_agent', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36')

config.bind('<Ctrl-Shift-k>', 'open -t /home/maren/dotfiles/i3/script/translate.sh')

config.source('~/.config/qutebrowser/qutewal.py')