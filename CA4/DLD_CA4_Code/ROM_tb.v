`timescale 1ns/1ns
module ROM_TB();

	reg[3:0] addrBus ;
   
	wire[7:0] outBus ;

    integer i;

	ROM  #(8,16) MMRY(.addrBus(addrBus), .outBus(outBus));

	initial begin

        for(i = 0; i < 16; i = i+1) 
            #5 addrBus = i;
                     
	    #10 $stop;
		
	end

endmodule

