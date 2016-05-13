1. Get help / show usage
    ```
    $ ./rb-fdholder -h
      Usage:
        rb-fdholder daemon /path/to/control/socket

        rb-fdholder get /path/to/control/socket 'keyname/or/watever' -- cat

        rb-fdholder put /path/to/control/socket '/some-key/name' < wat.txt

        rb-fdholder list /path/to/control/socket

        rb-fdholder delete /path/to/control/socket 'key'

        -h, --help  Print usage information
    ```

2. Start a fdholder daemon
    ```
    $ ./rb-fdholder daemon /service/rb-fdholder/s &
    [1] 40196
    ```

3. put file descriptor for `stdin` into the given key `/fuga`
    ```
    $ ./rb-fdholder put /service/rb-fdholder/s /fuga < <(head -n 10 wat.txt | gtac)
    I, [2016-05-13T01:51:39.674388 #40196]  INFO -- rb-fdholder-daemon: action: "put", path: "/fuga"
    I, [2016-05-13T01:51:39.674486 #40196]  INFO -- rb-fdholder-daemon: putting "/fuga": #<IO:fd 9>
    ```

4. List keys
    ```
    $ ./rb-fdholder list /service/rb-fdholder/s
    I, [2016-05-13T01:51:45.554748 #40196]  INFO -- rb-fdholder-daemon: action: "list", path: nil
    {"/fuga"=>#<IO:fd 9>}
    ```

5. Get the file descriptor at key `/fuga` and exec as `stdin` into the rest of the args past `--`
    ```
    $ ./rb-fdholder get /service/rb-fdholder/s /fuga -- rev
    I, [2016-05-13T01:51:55.278047 #40196]  INFO -- rb-fdholder-daemon: action: "get", path: "/fuga"
    I, [2016-05-13T01:51:55.278103 #40196]  INFO -- rb-fdholder-daemon: getting "/fuga": #<IO:0x007f99eb9ceb40>
    ekam yehT ?evals a gnieb tuoba gniht tsrow eht wonk uoY .girb eht ni reh worhT  )04(
    )93(
    .desuac uoy ssem 'lo taht pu 'ninaelc ecivres ytinummoc  )83(
    fo sruoh eviF :laed a uoy kcurts enod I tuB .elbuort 'o tekcub eceip-21  )73(
    a ni era lla'y eralced I ,reywal ruoy sa ,noS .ecnetepmocni ereht taht rof  )63(
    lairt gnitiawa elihw esac a gnidaelp drah mulp s'ti tub ,retteb enod ad'I lleW  )53(
    )43(
    !em dellik ev'uoY !uoy dlot tsuj I .peels ruoy ni deb ruoy ekam  )33(
    nac uoy litnu ecitcarp lliw uoY .deb edam llew a snaem taht dna ,enilpicsid  )23(
    si yrotciv ot yek ehT !yako ,tuB .esnes ekam t'nseod taht ,grebdioZ .rD  )13(
    ```

6. Delete a file descriptor and key stored in the fdholder daemon
    ```
    $ ./rb-fdholder delete /service/rb-fdholder/s /fuga
    I, [2016-05-13T01:51:59.956846 #40196]  INFO -- rb-fdholder-daemon: action: "delete", path: "/fuga"
    I, [2016-05-13T01:51:59.956901 #40196]  INFO -- rb-fdholder-daemon: deleting "/fuga": #<IO:0x007f99eb9ceb40>
    ```

7. List keys to show it was deleted
    ```
    $ ./rb-fdholder list /service/rb-fdholder/s
    I, [2016-05-13T01:52:02.368729 #40196]  INFO -- rb-fdholder-daemon: action: "list", path: nil
    {}
    ```
