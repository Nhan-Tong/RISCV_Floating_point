module data_mem #(
    parameter int unsigned DMEM_W = 12
) (
    input  logic [DMEM_W-1:0] paddr_i,
    input  logic              penable_i,
    input  logic              psel_i,
    input  logic              pwrite_i,
    input  logic [      31:0] pwdata_i,
    input  logic [       3:0] pstrb_i,
    output logic [      31:0] prdata_o,
    output logic   pready_o,
    output logic   pslverr_o,
    /* verilator lint_off UNUSED */
    input logic clk_i,
    input logic rst_ni
    /* verilator lint_on UNUSED */
);

  /* verilator lint_off UNUSED */
  logic unused;
  assign unused = |paddr_i[1:0];
  /* verilator lint_on UNUSED */

  logic [3:0][7:0] dmem[0:2**(DMEM_W-2)-1];

  initial begin
    for (int i = 0; i < 2 ** (DMEM_W - 2); i++) begin
      dmem[i] = 0;
    end
  end


  always_ff @(posedge clk_i or negedge rst_ni ) begin : proc_data
    if(!rst_ni) begin
      pslverr_o <= 0;
      pready_o <= 1;
    end
    else if (psel_i && penable_i && pwrite_i) begin
      if(paddr_i <= 2**(DMEM_W-2)-1) begin
        pready_o <= 1;
        pslverr_o <= 0;
        if (pstrb_i[0]) begin
          dmem[paddr_i[DMEM_W-1:2]][0] <= pwdata_i[7:0];
        end
        if (pstrb_i[1]) begin
          dmem[paddr_i[DMEM_W-1:2]][1] <= pwdata_i[15:8];
        end
        if (pstrb_i[2]) begin
          dmem[paddr_i[DMEM_W-1:2]][2] <= pwdata_i[23:16];
        end
        if (pstrb_i[3]) begin
          dmem[paddr_i[DMEM_W-1:2]][3] <= pwdata_i[31:24];
        end else begin
          pready_o <= 0;
          pslverr_o <= 1;
        end
      end
    end
    $writememh("./memory/data_mem.mem", dmem);
  end

  assign prdata_o = (pready_o & !pslverr_o)? dmem[paddr_i[DMEM_W-1:2]] : 0;


endmodule



