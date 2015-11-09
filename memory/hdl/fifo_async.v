module fifo_async 
   (/*AUTOARG*/
   // Outputs
   full, prog_full, dout, empty, valid,
   // Inputs
   rst, wr_clk, rd_clk, wr_en, din, rd_en
   );
   
   parameter DW    = 104;     //FIFO width
   parameter DEPTH = 32;      //FIFO depth
   parameter TYPE  = "XILINX";//"BASIC" or "XILINX" or "ALTERA"
   
   //##########
   //# RESET/CLOCK
   //##########
   input 	   rst;       //read/write reset
   input           wr_clk;    //write clock   
   input           rd_clk;    //read clock   

   //##########
   //# FIFO WRITE
   //##########
   input 	   wr_en;   
   input [DW-1:0]  din;
   output 	   full;
   output 	   prog_full;
   
   //###########
   //# FIFO READ
   //###########
   input 	   rd_en;
   output [DW-1:0] dout;
   output 	   empty;
   output 	   valid;

generate
if(TYPE=="BASIC") begin : basic   
   fifo_async_model 
     #(.DEPTH(DEPTH),
       .DW(DW))
   fifo_model (
	       /*AUTOINST*/
	       // Outputs
	       .full			(full),
	       .prog_full		(prog_full),
	       .dout			(dout[DW-1:0]),
	       .empty			(empty),
	       .valid			(valid),
	       // Inputs
	       .rst			(rst),
	       .wr_clk			(wr_clk),
	       .rd_clk			(rd_clk),
	       .wr_en			(wr_en),
	       .din			(din[DW-1:0]),
	       .rd_en			(rd_en));
end
else if (TYPE=="XILINX") begin : xilinx
   if((DW==104) & (DEPTH==32))
     begin
	fifo_async_104x32 fifo_async_104x32 (
					     /*AUTOINST*/
					     // Outputs
					     .full		(full),
					     .prog_full		(prog_full),
					     .dout		(dout[DW-1:0]),
					     .empty		(empty),
					     .valid		(valid),
					     // Inputs
					     .rst		(rst),
					     .wr_clk		(wr_clk),
					     .rd_clk		(rd_clk),
					     .wr_en		(wr_en),
					     .din		(din[DW-1:0]),
					     .rd_en		(rd_en));
	
     end // if ((DW==104) & (DEPTH==32))
end // block: xilinx   
endgenerate
   
endmodule // fifo_async
// Local Variables:
// verilog-library-directories:("." "../fpga/" "../dv")
// End:
