# renewable_spot_market
second 100% renewable grid study 

This is a Monte Carlo analysis of supply/demand performance for a 100% renewable grid supplying a single city - Melbourne. 

Generators: 

Wind with 3.0, 4.5, 5.5 m/sec 

Solar generators at Alice Springs and Mildura. Hour by hour statistics derived from the BOM 1 minute data. 

Process of simulation:

Calculate total supply from samples of the total generated power distribution.

If there is a surplus then fill storage until it is full.

If there is a deficit, first try to use storage. When that is exhausted use hydro. 

