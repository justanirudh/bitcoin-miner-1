defmodule Slave do
    @range 1000
    @username "paanir"

    #change start of range from 1 to a bigger number say 100. end to be say 200-300
    #can cut off the last 'm digits'. might decrease probability of collision
    def mine(expected_num_zeroes, caller) do
        #random string generation
        rand_string =  @username <> (:rand.uniform(@range) |> :crypto.strong_rand_bytes |> Base.encode64)
        #hash generation
        hash = :crypto.hash(:sha256, rand_string) |> Base.encode16
        #zero counting
        num_leading_zeroes = count(hash, 0)
        #checking expected number of zeroes        
        if(num_leading_zeroes == expected_num_zeroes) do
            send caller, {rand_string, hash}
        end
        mine(expected_num_zeroes, caller)
    end

    defp count(str , val) do
        case {str, val} do
            {"0" <> rest, val} -> count(rest, val + 1)
            _ -> val
        end
    end

end