module DisjunctionFormula (
    input logic phi1,
    input logic phi2,
    output logic y
);
    assign y = phi1 | phi2;
endmodule
