ns-checker-test.rb
====

```
$ ./ns-checker-test.rb
{
 "target_tld":"io",
 "target_fqdn":"scrapbox.io",
 "authoritative_ns":[  {
   "name":"a0.nic.io",
   "address":[    "65.22.160.17"],
   "result":[    "ns1.dnsimple.com",    "ns2.dnsimple.com",    "ns3.dnsimple.com",    "ns4.dnsimple.com"]
  },  {
   "name":"b0.nic.io",
   "address":[    "65.22.161.17"],
   "result":[    "ns1.dnsimple.com",    "ns2.dnsimple.com",    "ns3.dnsimple.com",    "ns4.dnsimple.com"]
  },  {
   "name":"c0.nic.io",
   "address":[    "65.22.162.17"],
   "result":[    "ns1.dnsimple.com",    "ns2.dnsimple.com",    "ns3.dnsimple.com",    "ns4.dnsimple.com"]
  },  {
   "name":"ns-a1.io",
   "address":[    "194.0.1.1"],
   "result":[    "ns1.dnsimple.com",    "ns2.dnsimple.com",    "ns3.dnsimple.com",    "ns4.dnsimple.com"]
  },  {
   "name":"ns-a2.io",
   "address":[    "194.0.2.1"],
   "result":[    "ns1.dnsimple.com",    "ns2.dnsimple.com",    "ns3.dnsimple.com",    "ns4.dnsimple.com"]
  },  {
   "name":"ns-a3.io",
   "address":[    "74.116.178.1"],
   "result":[]    // <= timeout?
  },  {
   "name":"ns-a4.io",
   "address":[    "74.116.179.1"],
   "result":[    "ns1.dnsimple.com",    "ns2.dnsimple.com",    "ns3.dnsimple.com",    "ns4.dnsimple.com"]
  }]
}
```

Copyright and license
----
Copyright (c) 2017 yoggy

Released under the [MIT license](LICENSE.txt)

