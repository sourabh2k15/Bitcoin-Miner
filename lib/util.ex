defmodule Util do
    # generates string with k zeros
	def ref_string(k) do
		Enum.join(Enum.map(0..k-1, fn _ -> "0" end), "")
	end

	# checks if string has k leading zeros
	def check_hash(s, k) do
		if String.slice(s, 0..k-1) === ref_string(k) do
			true
		else
			false
		end
	end

	# gets node IP address
	def get_ips do
		{:ok, ifs} = :inet.getif()
		ips = Enum.map(ifs, fn {ip, _broadaddr, _mask} -> Enum.join(Tuple.to_list(ip), ".") end)

		ips
		|> Enum.with_index
		|> Enum.reduce(%{}, fn({ip, index}, acc) ->
			Map.put(acc, index, ip)
		   end)
	end

    #generates a random string
    def randstr do
        _ = :rand.seed(:exs1024, {:rand.uniform(100), :rand.uniform(10000), :rand.uniform(1000)})
        len = Enum.random(1..10)
		:crypto.strong_rand_bytes(len) |> Base.encode16
	end

	def randid do
		_ = :rand.seed(:exs1024, {:rand.uniform(100), :rand.uniform(10000), :rand.uniform(1000)})
		:rand.uniform(100000000) |> Integer.to_string
	end
end
