defmodule SlaveNode do
    
    #slave (./project ip)
    def start(app_name, master_ip) do
        setup_node(app_name)
        connect_to_master(app_name, master_ip)
        master_pid = :global.whereis_name(:master)
        num_zeroes = request_work(master_pid)
        Master.start(num_zeroes, {:from_slave, master_pid}) #this request coming from a :slave
    end 

    defp setup_node(app_name) do
        current_ip = Utils.get_current_ip()     
        {:ok, _} = Utils.get_longname(app_name, "slave", current_ip) |> Node.start #converts current node to distributed node
        Application.get_env(app_name, :cookie) |> Node.set_cookie #gets common cookie and sets the master's with it
    end

    defp connect_to_master(app_name, master_ip) do
        _ = Utils.get_longname(app_name, "master", master_ip) |> Node.connect #connect to master #TODO: make a loop here to keep retrying until succeeds
        :global.sync #sync global registry to let slave know of master being named :master
    end

    defp request_work(master_pid) do
        slave_pid = self() # current BEAM process is slave             
        send master_pid, {:slave, slave_pid} #send request to master asking for work
        receive do #get the number of zeroes to be mined from master
            num_zeroes -> num_zeroes
        end
    end

end