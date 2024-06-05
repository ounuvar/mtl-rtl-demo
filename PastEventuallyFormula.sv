module PastEventuallyFormula (
    input logic clk,
    input logic phi,
    output logic y
);
    logic v;

    always_ff @(posedge clk) begin
        v <= phi | v;
    end

    assign y = v;
endmodule
