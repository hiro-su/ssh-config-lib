# Ssh::Config::Lib

sshの設定ファイルを編集するためのライブラリです。
- update
- generate(作成予定)

## インストール

    git clone https://github.com/hiro-su/ssh-config-lib.git
    cd ssh-config-lib
    rake build
    gem install pkg/ssh-config-lib-0.0.1.gem


## 使い方 
以下のスクリプトを実行します

    # exec.rb
    require "ssh-config-lib"
    
    api_data = {
      "test1" => {"HostName" => "sample", "User" => "nya-", "port" => 22},
      "test2" => {"port" => 23},
      "test3" => {"HostName" => "hogehogehogehoge"},
    }
    
    include SSH::Config
    # set your ssh config file
    Update.config = "config"
    Update.run api_data


    $ ruby exec.rb
    
    
実行前の設定ファイル

    ServerAliveInterval 15
    
    Host test1
    HostName      example1
    User          hiro-su
    
    Host test2
    HostName      example2
    IdentityFile  ~/.ssh/id_rsa
    User          hiro-su
    port          22
    
    Host test3
    HostName      example3
    IdentityFile  ~/.ssh/id_rsa
    User          hiro-su
    ProxyCommand  ssh -W %h:%p test2

実行後の設定ファイル

    ServerAliveInterval 15
    
    Host test1
    HostName      sample
    User          nya-
    port          22
    
    Host test2
    HostName      example2
    IdentityFile  ~/.ssh/id_rsa
    User          hiro-su
    port          23
    
    Host test3
    HostName      hogehogehogehoge
    IdentityFile  ~/.ssh/id_rsa
    User          hiro-su
    ProxyCommand  ssh -W %h:%p test2 
    
スクリプト実行前の設定ファイルは filename.timestamp.bak の形式で保存されます。 

    config
    config.1362023450.bak
