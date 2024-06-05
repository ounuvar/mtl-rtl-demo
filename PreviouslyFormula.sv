module PreviouslyFormula (
    input logic clk,
    input logic phi,
    output logic y
);
    logic v;

    always_ff @(posedge clk) begin
        v <= phi;
    end

    assign y = v;
endmodule
