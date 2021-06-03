**Compiling Plutus Scripts for use with CLI commands**

1. Make sure that you have installed and are using recent versions of `ghc` and `cabal`, e.g. GHC 8.10.2 or later.

2. Create a new source file/project based on the template at: [https://github.com/input-output-hk/...](https://github.com/input-output-hk/)

2. Check that you can build the project successfully: `cabal build compile -w ghc-8.10.4`

3. Install the `compile` build: `cabal install compile -w ghc-8.10.4`
4. Run the `compile` command and verify the output
```
$ compile
"\SOH\NUL\NUL2...\DC1"
```

6.	Write your own Plutus script to replace the example `equals` script
```
myscript :: P.Data -> P.Data -> P.Data -> ()
myscript d1 d2 d3 = if d1 O.== d2 && not (d1 P.== d3) then () else (P.error ())
```
(each `P.Data` corresponds to a datum at execution time)

7.	Replace the quoted ``equals`` with the name of your new script.  Note that this must be the name of a top-level definition within the same module.
```
$$(P.compile [|| myscript ||])
```

8. Build, run and check that you get a different byte-string output.
9. Save the output into a file and pass the name of this file to the `cardano-cli transaction build-raw` command.
10. You can now sign and submit the transaction as usual.
