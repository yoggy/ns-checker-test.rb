#!/usr/bin/ruby
#
# ns-checker-test.rb - authoritative name servers checker
#
# github:
#     https://github.com/yoggy/ns-checker-test.rb
#
# license:
#     Copyright (c) 2017 yoggy <yoggy0@gmail.com>
#     Released under the MIT license
#     http://opensource.org/licenses/mit-license.php;
#
require 'resolv'
require 'json'
require 'pp'

rv = {}
rv["target_tld"]  = "io"
rv["target_fqdn"] = "scrapbox.io"
rv["authoritative_ns"] = []

# see also... https://github.com/ruby/ruby/commit/365c3215855ae2f4412a8e198d7d4facd27a7d67#diff-5eaee83b511bb5c304d686f8f47dc6c2
class MonkeyPatchedDNS < Resolv::DNS
  def extract_resources(msg, name, typeclass) # :nodoc:
    n0 = Name.create(name)
    msg.each_resource {|n, ttl, data|
      yield data if n0 == n
    }
  end
end

google_dns = Resolv::DNS.new(nameserver_port: [['8.8.8.8', 53]])

# authoritative name servers
google_dns.each_resource(rv["target_tld"], Resolv::DNS::Resource::IN::NS) do |r|
  ns = {}
  ns["name"] = r.name.to_s
  rv["authoritative_ns"] << ns
end
rv["authoritative_ns"].sort! do |a,b| a["name"] <=> b["name"] end

# ip address of authoritative_ns
rv["authoritative_ns"].each do |ns|
  ns["address"] = []
  google_dns.each_resource(ns["name"], Resolv::DNS::Resource::IN::A) do |r|
    ns["address"] << r.address.to_s
  end
  ns["address"].sort!
end

google_dns.close

# query for target_fqdn 
rv["authoritative_ns"].each do |ns|
  ns["result"] = []
  ns["address"].each do |addr|
    dns = MonkeyPatchedDNS.new(nameserver_port: [[addr, 53]])
    dns.timeouts = 10
    dns.each_resource(rv["target_fqdn"], Resolv::DNS::Resource::IN::NS) do |r|
      ns["result"] << r.name.to_s unless ns["result"].include? r.name.to_s
    end
    ns["result"].sort!
    dns.close
    sleep 0.5
  end
end

puts rv.to_json(:indent => ' ', :object_nl => "\n", :space => '')
