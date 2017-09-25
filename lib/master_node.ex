defmodule MasterNode do

    #master (./project1 num_zeroes)
    def start(app_name, arg) do
        setup_node(app_name) #makes current node distributed and register
        num_zeroes = String.to_integer(arg)
        # master starts its own mining. this request coming from a master
        {:ok, master_master} = Task.start(Master, :start, [num_zeroes, :from_master]) 
        loop(num_zeroes, master_master) # gets requests from slaves  
    end

    defp setup_node(app_name) do
        master = self() # current BEAM process is master
        {:ok, _} = Utils.get_longname(app_name, "master", Utils.get_current_ip()) |> Node.start #converts current node to distributed node
        Application.get_env(app_name, :cookie) |> Node.set_cookie #gets common cookie and sets the master's with it
        :global.register_name(:master, master) #registers it for all connected nodes
    end

    #get requests from slaves
    defp loop(num_zeroes, master_master) do
        receive do
            {:slave, slave_pid} -> send slave_pid, num_zeroes
            #send to master's master process so that all results can share the same hashmap
            {rand_string, hash} -> send master_master, {rand_string, hash} #to master_master
        end
        loop(num_zeroes, master_master)
    end
        
end