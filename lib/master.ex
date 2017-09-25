defmodule Master do
    @num_slaves 1000

    def start(num_zeroes, source) do
        caller = self()
        1..@num_slaves |> Enum.map(fn(_) -> spawn(Slave, :mine, [num_zeroes, caller]) end)
        case source do
            :from_master -> loop_master (MapSet.new) #if master. print it
            {:from_slave, master_pid} -> loop_slave (master_pid) #if slave, send to master
        end
    end

    #if master, print
    defp loop_master(mapset) do
        mapset = receive do
            {rand_string, hash} -> 
                if(MapSet.member?(mapset, rand_string) == false) do
                    IO.puts rand_string <> "\t" <> hash
                    MapSet.put(mapset, rand_string)
                else
                    mapset
                end
        end
        loop_master(mapset)
    end

    #if slave, send to master
    defp loop_slave(master_pid) do
        receive do            
            {rand_string, hash} -> send master_pid, {rand_string, hash}
        end
        loop_slave(master_pid)
    end

end