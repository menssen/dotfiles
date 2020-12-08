source ~/.zshcreds

COPYFILE_DISABLE=true

# Homebrew
PATH=/usr/local/sbin:/usr/local/bin:$PATH

# Ruby
PATH=/usr/local/lib/ruby/gems/2.7.0/bin:/usr/local/opt/ruby/bin:$PATH
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

# # Terraform
# PATH="/usr/local/opt/terraform@0.12/bin:$PATH"

# Perforce
export P4PORT=1666
export P4HOST=TYR-RV-ENG2P.AD.CORP.GLOBAL
export P4USER=cccfjd
export P4PASSWD="$ZSH_CREDENTIALS_P4PASSWD"

# iCloud Drive Shortcut
export IC='/Users/dan/Library/Mobile Documents/com~apple~CloudDocs'

# Always use neovim for editor
export SVN_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

# # Java
# export CATALINA_OPTS="-Xmx2048m -XX:MaxPermSize=1024m"
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-9.jdk/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.7.jdk/Contents/Home
# export CATALINA_PID="/usr/local/Cellar/tomcat/8.0.15/libexec/catalina_pid.txt"

# AWS
export AWS_ACCESS_KEY_ID="$ZSH_CREDENTIALS_AWS_ACCESS_KEY_ID_TIS_DEV"
export AWS_SECRET_ACCESS_KEY="$ZSH_CREDENTIALS_AWS_SECRET_ACCESS_KEY_TIS_DEV"

# Android
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"
