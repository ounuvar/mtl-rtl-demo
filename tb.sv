module tb;
    logic clk = 1;
    initial forever #(`CLK_PERIOD/2) clk = ~clk;
    bit rst = 0;

    logic p;
    logic q;
    logic y_top;
    logic [0:`MAX_TIME-1] t;

    logic y_disj;
    DisjunctionFormula disj (
        .phi1(p),
        .phi2(q),
        .y(y_disj)
    );

    logic y_tpe1;
    TimedPastEventuallyFormula #(
        .a(1),
        .b(2)
    ) tpe1 (
        .clk(clk),
        .rst(rst),
        .t(t),
        .phi(y_disj),
        .y(y_tpe1)
    );

    TimedPastEventuallyFormula #(
        .a(1),
        .b(2)
    ) tpe2 (
        .clk(clk),
        .rst(rst),
        .t(t),
        .phi(y_tpe1),
        .y(y_top)
    );

    parameter int unsigned N_CYCLES = 6;
    bit [0:N_CYCLES] [1:0] pq = {
        {1'b0, 1'b0},
        {1'b1, 1'b0},
        {1'b0, 1'b0},
        {1'b0, 1'b0},
        {1'b0, 1'b0},
        {1'b0, 1'b1},
        {1'b0, 1'b0}
    };

    int signed first;
    int signed last;
    function string interval_repr(logic [0:`MAX_TIME-1] t);
        first = -1;
        last = -1;
        for (int i = 0; i < `MAX_TIME; i++) begin
            if (t[i]) begin
                if (first == -1) first = i;
                last = i;
            end
        end
        if (first == -1) begin
            return "ø";
        end else if (first == last) begin
            return $sformatf("{%0d}", first);
        end else begin
            return $sformatf("[%0d, %0d]", first, last);
        end
    endfunction

    initial begin
        #1;
        rst = 1;
        #1;
        rst = 0;
        t = {1'b1, {`MAX_TIME-1{1'b0}}};
        for (int i = 0; i <= N_CYCLES; i++) begin
            #1;
            if (i != 0) t >>= 1;
            {p, q} = pq[i];
            #1;
            $display("k: %0d", i);
            $display("p: %0s", i == 0 ? "" : p ? "T" : "F");
            $display("q: %0s", i == 0 ? "" : q ? "T" : "F");
            $display("V_ϕ(1): %0s", y_disj ? "T" : "F");
            $display("V_ϕ(2): %0s", interval_repr(tpe1.v_r_next));
            $display("V_ϕ(3): %0s", interval_repr(tpe2.v_r_next));
            $display("Y_ϕ: %0s", i == 0 ? "" : y_top ? "T" : "F");
            $display("--------------------------------");
            #1;
            @(posedge clk);
            #1;
        end
        $finish(0);
    end
endmodule
