defmodule Worker do
    @work_unit 10000
    @gatorid "smedapati"

    def start(k) do
        Enum.each(1..k, fn(x) -> 
            IO.puts x
        end)
    end

    def start(counter, length, k) do
        if length > 0 do
            pid = spawn(fn -> compute() end)
            send(pid, {:contract, self(), counter, length, k})
    
            loop()
        else
			Client.request_work
        end
    end

    def loop do 
        receive do
            {:started, update, length, k} ->
                :timer.sleep 1
				start(update, length, k)
            {:collision, s, h} ->
				IO.puts s<>"    "<>h
				loop()
	    end
    end

    def compute do
		receive do
			{:contract, head, counter, length, k} ->
				send(head, {:started, counter + @work_unit, length - @work_unit, k})
				
				Enum.each(counter..counter + @work_unit, fn x ->
                    s = @gatorid <> Integer.to_string(x)
					h = :crypto.hash(:sha256, s) |> Base.encode16

                    if Util.check_hash(h, k) do
						send(head, {:collision, s, h})
					end
				end)

		end
    end
end