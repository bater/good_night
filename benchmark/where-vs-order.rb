require_relative '../config/environment'
require 'benchmark/ips'

def where_first
  Sleep.where(user_id: [1,2,3]).past_week
end

def order_first
  Sleep.past_week.where(user_id: [1,2,3])
end

Benchmark.ips do |x|
  x.report('where_first') { where_first }
  x.report('order_first') { order_first }
  x.compare!
end

# ruby benchmark/where-vs-order.rb
=begin
Warming up --------------------------------------
         where_first   645.000  i/100ms
         order_first   686.000  i/100ms
Calculating -------------------------------------
         where_first      6.462k (± 1.7%) i/s -     32.895k in   5.091940s
         order_first      6.923k (± 1.8%) i/s -     34.986k in   5.054831s

Comparison:
         order_first:     6923.5 i/s
         where_first:     6462.1 i/s - 1.07x  (± 0.00) slower
=end