`include "main.v"

module LED_Chasing_tb;
    reg clk, reset;
    reg buttonPressed;
    reg[3:0] stopValue;
    wire Result, LED1, LED2, LED3, LED4;
    LED_Chasing Game(.clk(clk), 
                    .stopButton(buttonPressed),
                    .stopLED(stopValue),
                    .reset(reset),
                    .Result(Result),
                    .LED1(LED1),
                    .LED2(LED2),
                    .LED3(LED3),
                    .LED4(LED4));
    initial
    begin
        clk = 1;
        forever
        begin
            #5 clk = 0;
            #5 clk = 1;
        end
    end

    initial begin;
        $dumpfile("main_tb.vcd");
        $dumpvars(0, LED_Chasing_tb);

        reset = 1; buttonPressed = 0; stopValue <= 4'b1000;
        #100
        reset = 0;
        #121
        buttonPressed = 1;
        #200
        $finish;
    end
endmodule
