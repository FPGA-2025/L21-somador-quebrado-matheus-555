`timescale 1ns/1ps

module tb();

integer i;
localparam QTDE_TESTES = 24;

reg [3:0] num1;
reg [3:0] num2;
wire [3:0] out;
wire cout;

reg cout_txt;
reg [3:0] out_txt;
reg [15:0] dados_arquivo [0:QTDE_TESTES-1];

add u0 (
    .num1 (num1),
    .num2 (num2),
    .out  (out),
    .cout (cout)
);

initial begin
    // Insira o seu teste aqui

    $readmemb("teste.txt", dados_arquivo);
    $dumpfile("saida.vcd");
    $dumpvars(0, tb);

    for(i = 0; i < QTDE_TESTES; i = i+1) begin
        num1     = dados_arquivo[i][8:5];
        num2     = dados_arquivo[i][12:9];
        out_txt  = dados_arquivo[i][4:1];
        cout_txt = dados_arquivo[i][0];
        #1;

        if (out == out_txt && cout == cout_txt)
            $display("num1=%d num2=%d out=%d cout=%d (OK)", num1, num2, out, cout);
        else
            $display("num1=%d num2=%d out=%d cout=%d (ERRO)", num1, num2, out, cout);
    end

    $finish;
end

endmodule
