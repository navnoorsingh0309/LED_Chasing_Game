//Stop Button Module
module buttonControl (
    input clk,
    input button,
    input reset,
    input[3:0] stopLED,
    input[3:0] LEDvalue,
    output reg WinOrLoss
    
);
    //If button is Pressed or Released
    always @(button) begin
        //Reset
        if(reset) begin
            WinOrLoss <= 1'b0;
        end
        else
        begin
            //Button Pressed
            if(button == 1'b1)
            begin
                //If LED Matched
                if(stopLED == LEDvalue)
                    WinOrLoss <= 1'b1;
                else
                    WinOrLoss <= 1'b0;
            end
        end
    end
endmodule

//Main Module
module LED_Chasing (
    input clk,
    input reset,
    input[3:0] stopLED,
    input stopButton,
    output reg Result, LED1, LED2, LED3, LED4
);
    //LED On value
    reg[3:0] LEDOn = 4'b0000;
    //Wire to get result and interconnect modules
    wire EndVal;
    //clk changes
    always @(posedge clk) begin
        //Reset
        if(reset) begin
            LEDOn <= 4'b0000;
            LED1 <= 1'b0;
            LED2 <= 1'b0;
            LED3 <= 1'b0;
            LED4 <= 1'b0;
            Result = 0;
        end
        else begin
            //LEDs getting switched on one by one
            if(LEDOn == 4'b0000) begin
                LED1 <= 1'b1;
                LEDOn <= 4'b1000;
            end
            else if(LEDOn == 4'b1000) begin
                LED1 <= 1'b0;
                LED2 <= 1'b1;
                LEDOn <= 4'b0100;
            end
            else if(LEDOn == 4'b0100) begin
                LED2 <= 1'b0;
                LED3 <= 1'b1;
                LEDOn <= 4'b0010;
            end
            else if(LEDOn == 4'b0010) begin
                LED3 <= 1'b0;
                LED4 <= 1'b1;
                LEDOn <= 4'b0001;
            end
            else if(LEDOn == 4'b0001) begin
                LED4 <= 1'b0;
                LED1 <= 1'b1;
                LEDOn <= 4'b1000;
            end
        end
    end

    //Outputing value
    always @(EndVal) begin
        if(EndVal == 0)
            Result <= 0;
        else
            Result <= 1;
    end
    //Initlizing button
    buttonControl stopButtonCtrl(
        .clk(clk),
        .reset(reset),
        .button(stopButton),
        .stopLED(stopLED),
        .LEDvalue(LEDOn),
        .WinOrLoss(EndVal)
    );
endmodule
