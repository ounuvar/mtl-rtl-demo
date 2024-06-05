module InversionFormula (
    input logic phi,
    output logic y
);
    assign y = ~phi;
endmodule
