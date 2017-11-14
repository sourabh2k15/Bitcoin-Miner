defmodule Server do
	@global_workunit :math.pow(2,25) |> round

	def main(args\\[]) do
		args |> parse_args
	end

	def parse_args(args) when length(args) == 0 do
		IO.puts " usage: \n ./project1 k \n or \n ./project1 ip_addr"
	end

	def parse_args(args) when length(args) == 1 do
		a = String.split(hd(args), ".")

		if length(a) == 4 do
			# argument ip_addr passed
			Client.contact_server(hd(args))
		else
			# argument K passed
			k = String.to_integer(hd(a))
	
			{:ok, _} = Node.start choose_ip()
			:global.register_name("head", self())
			
			Client.request_work
			listen(0, k)
		end
	end

	def listen(global_counter, k) do
		receive do 
			{:worker_request, node} ->
				Node.spawn(node, Worker, :start, [global_counter, @global_workunit, k])
				listen(global_counter + @global_workunit, k)
		end
	end

	def choose_ip do
		ipmap  = Util.get_ips
		IO.puts "\nplease enter option number of ip address the server should listen on:\n"

		Enum.each ipmap, fn {idx ,ip_addr} -> 
			IO.puts "#{idx+1})  #{ip_addr} \n"
		end

		{option,_} = IO.getn("option : ", 1) |> Integer.parse
		server_ip = ipmap[option-1]
	
		_ = System.cmd("epmd", ['-daemon'])
		String.to_atom("head_node@"<>server_ip)
	end
end