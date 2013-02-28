#encoding: utf-8
require File.expand_path(File.dirname(__FILE__)) + "/helper.rb"

api_data = {
  "test1" => {"HostName" => "sample", "User" => "nya-", "port" => 22},
  "test2" => {"port" => 23},
  "test3" => {"HostName" => "hogehogehogehoge"},
}

include SSH::Config
Update.config = "config"
Update.run api_data
