defmodule Utils do
    def get_current_ip do
        #get ip of current node
        {:ok, [ tuples | _]} = :inet.getif
        elem(tuples,0) |> :inet_parse.ntoa
    end

    def get_longname(app_name, node_type, ip) do
        String.to_atom("#{app_name}-#{node_type}@#{ip}")
    end

end