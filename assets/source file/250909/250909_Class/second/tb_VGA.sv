`timescale 1ns / 1ps

class BMP_File;
    byte bmp_total[640*480*3+54];
    byte bmp_header[54];
    byte bmp_data[640*480*3];

    int bmp_size, bmp_data_offset, bmp_width, bmp_height, biBitCount;
    string sourcefileName = "Rengoku_640x480.bmp";
    string targetfileName = "target_640x480.bmp";

    int srcfileID, trgFileID, readSize;

    function new();
                
    endfunction

    task readFileHeader();
        readSize = $fread(bmp_total, srcfileID);
        $fclose(srcfileID);

        $display("[%s] read size : %0d", sourcefileName, readSize);

        bmp_size = {bmp_total[5], bmp_total[4], bmp_total[3], bmp_total[2]};
        $display("[%s] bmp size : %0d", sourcefileName, bmp_size);

        bmp_data_offset = {
            bmp_total[13], bmp_total[12], bmp_total[11], bmp_total[10]
        };
        $display("[%s] bmp image offset : %0d", sourcefileName,
                 bmp_data_offset);

        bmp_width = {
            bmp_total[21], bmp_total[20], bmp_total[19], bmp_total[18]
        };
        bmp_height = {
            bmp_total[25], bmp_total[24], bmp_total[23], bmp_total[22]
        };
        $display("[%s] bmp image %0d x %0d", sourcefileName, bmp_width,
                 bmp_height);

        biBitCount = {bmp_total[29], bmp_total[28]};
        $display("[%s] bmp bit %0d", sourcefileName, biBitCount);

        if (biBitCount != 24) begin
            $display("[%s] biBitCount need to be 24bit", sourcefileName);
            $finish;
        end

        if (bmp_width % 4) begin
            $display("[%s] bmp width %% 4 need to be zero!", sourcefileName);
            $finish;
        end

    endtask

    task copyHeader();
        // copy header
        for (int i = 0; i < bmp_data_offset; i++) begin
            bmp_header[i] = bmp_total[i];
        end
    endtask

    task copyData();
        // copy image
        for (int i = bmp_data_offset; i < 640 * 480 * 3; i++) begin
            bmp_data[i-bmp_data_offset] = bmp_total[i];
        end
    endtask

    task OpenBMP();
        srcfileID = $fopen(sourcefileName, "rb");
        if (!srcfileID) begin
            $display("Open [%s] BMP File Error!", sourcefileName);
            $finish;
        end
    endtask

    task WriteBMP();
        trgFileID = $fopen(targetfileName, "wb");

        for (int i = 0; i < bmp_data_offset; i++) begin
            $fwrite(trgFileID, "%c", bmp_header[i]);
        end

        for (int i = 0; i < bmp_size - bmp_data_offset; i++) begin
            $fwrite(trgFileID, "%c", bmp_data[i]);
        end
        $fclose(trgFileID);
        $display("Write BMP File Done!");
    endtask
endclass


module tb_VGA ();
    /*
    byte bmp_total[640*480*3+54];
    byte bmp_header[54];
    byte bmp_data[640*480*3];

    int bmp_size, bmp_data_offset, bmp_width, bmp_height, biBitCount;
    string sourcefileName = "Rengoku_640x480.bmp";
    string targetfileName = "target_640x480.bmp";

    task ReadBMP();
        int fileID, readSize;

        fileID = $fopen(sourcefileName, "rb");
        if (!fileID) begin
            $display("Open [%s] BMP File Error!", sourcefileName);
            $finish;
        end

        readSize = $fread(bmp_total, fileID);
        $fclose(fileID);

        $display("[%s] read size : %0d", sourcefileName, readSize);

        bmp_size = {bmp_total[5], bmp_total[4], bmp_total[3], bmp_total[2]};
        $display("[%s] bmp size : %0d", sourcefileName, bmp_size);

        bmp_data_offset = {
            bmp_total[13], bmp_total[12], bmp_total[11], bmp_total[10]
        };
        $display("[%s] bmp image offset : %0d", sourcefileName,
                 bmp_data_offset);

        bmp_width = {
            bmp_total[21], bmp_total[20], bmp_total[19], bmp_total[18]
        };
        bmp_height = {
            bmp_total[25], bmp_total[24], bmp_total[23], bmp_total[22]
        };
        $display("[%s] bmp image %0d x %0d", sourcefileName, bmp_width,
                 bmp_height);

        biBitCount = {bmp_total[29], bmp_total[28]};
        $display("[%s] bmp bit %0d", sourcefileName, biBitCount);

        if (biBitCount != 24) begin
            $display("[%s] biBitCount need to be 24bit", sourcefileName);
            $finish;
        end

        if (bmp_width % 4) begin
            $display("[%s] bmp width %% 4 need to be zero!", sourcefileName);
            $finish;
        end

        // copy header
        for (int i = 0; i < bmp_data_offset; i++) begin
            bmp_header[i] = bmp_total[i];
        end

        // copy image
        for (int i = bmp_data_offset; i < 640 * 480 * 3; i++) begin
            bmp_data[i-bmp_data_offset] = bmp_total[i];
        end

    endtask

    task WriteBMP();
        int fileID;
        fileID = $fopen(targetfileName, "wb");

        for (int i = 0; i < bmp_data_offset; i++) begin
            $fwrite(fileID, "%c", bmp_header[i]);
        end

        for (int i = 0; i < bmp_size - bmp_data_offset; i++) begin
            $fwrite(fileID, "%c", bmp_data[i]);
        end
        $fclose(fileID);
        $display("Write BMP File Done!");
    endtask
*/

    BMP_File bmp_img;

    initial begin
        bmp_img = new();

        bmp_img.OpenBMP();
        bmp_img.readFileHeader();
        bmp_img.copyHeader();
        bmp_img.copyData();
        bmp_img.WriteBMP();
    end

endmodule
