# Miner

## Design:
A master spawns 1000 slave processes
Each slave process mines coins independent of any other slave process using random string generators
When a slave finds a coin, it send it to the master
Master checks if the coin has been discovered before. If not, it prints it

# Design flaws
Checking for collisions is not ideal. If number of zeroes to be found is less, our process can run out of 
memory pretty fast as the size of map in the server implodes
These design issues have been handled in bitcoin-miner-2

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `project1` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:project1, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/project1](https://hexdocs.pm/project1).


##  How to run
epmd -daemon #runs the Erlang port mapper daemon
mix escript.build #compiles the project and creates an executable named 'miner'

./miner 3 (as a master, to find bitcoins with 3 prepending zeroes)
./miner <ip-address> (as a slave, to request for work)

