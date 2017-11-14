defmodule Client do
    def contact_server(ip) do
	name = String.to_atom(Util.randstr() <> "@127.0.0.1")
	_ = System.cmd("epmd", ['-daemon'])

	{:ok, _} = Node.start name
	b = Node.connect(String.to_atom("head_node@"<>ip))

	if b do
	    :global.sync()
	    :global.registered_names()
            
	    Client.request_work
            
	    receive do
                {msg} -> msg 
            end
	else	
            IO.puts "failed to connect to head_node"
	end
    end

    def request_work do
        pid = :global.whereis_name("head")
	send(pid, {:worker_request, Node.self()})
    end
end
