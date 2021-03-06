#========================================================================================================================
# Copyright (c) 2015 by Bitvis AS.  All rights reserved.
#
# BITVIS UTILITY LIBRARY AND ANY PART THEREOF ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH BITVIS UTILITY LIBRARY.
#========================================================================================================================

#
# Fix 'vmap'
#
#     This is a fix for a bug in Modelsim's 'vmap' command, resulting in Modelsim
#     incorrectly reporting successful modification of 'modelsim.ini'.
#
#     On some Linux hosts, Modelsim reports "Modifying modelsim.ini" when vmap is 
#     executed without acutally modifying 'modelsim.ini' file. This script test to 
#     check if the bug exists, and provides an aleternate 'vmap' command that 
#     modifies 'modelsim.ini' file as expected by Modelsim.
#

vlib test-FM-8-lib
vmap test-FM-8 test-FM-8-lib

if { [catch {vmap test-FM-8}] } {
    # Bug exists

    echo "Detected vmap bug."
    proc vmap { lib path } {
        set timestamp [clock format [clock seconds] -format {%Y%m%d%H%M%S}]
        set filename "modelsim.ini"
        set temp     $filename.new.$timestamp
        set backup   $filename.bak.$timestamp
        
        set in  [open $filename r]
        set out [open $temp     w]

        # line-by-line, read the original file
        while { [gets $in line] != -1 } {
            # Write the line
            puts $out $line
            
            if { [string equal $line "\[Library\]"] } {
                puts $out "$lib = $path\n"
            }
        }

        close $in
        close $out
        
        # move the new data to the proper filename
        file rename -force $filename $backup
        file rename -force $temp $filename 

    }    


} else {
    vmap -del test-FM-8
}
vdel -all -lib test-FM-8-lib

