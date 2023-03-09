# Lab 5: Roman Szymutko
### Pre-lab preparation
 | **CLK** | **D** | **Q(n)** | **Q(n+1)** | **Comment** |
 | :-: | :-: | :-: | :-: | :-: |
 | ↑ | 0 | 0 | 0 | Q(n+1) has always same level as D when enabled by CLK edge |
 | ↑ | 0 | 1 | 0 | Q(n+1) has always same level as D when enabled by CLK edge |
 | ↑ | 1 | 0 | 1 | Q(n+1) has always same level as D when enabled by CLK edge |
 | ↑ | 1 | 1 | 1 | Q(n+1) has always same level as D when enabled by CLK edge |
 
 ![characteristic equation for D](img/d-char-eq.png)
 </br>
 | **CLK** | **J** | **K** | **Q(n)** | **Q(n+1)** | **Comment** |
 | :-:     | :-:   | :-:   | :-:      | :-:        | :-:         |
 | ↑ | 0 | 0 | 0 | 0 | Memory |
 | ↑ | 0 | 0 | 1 | 1 | Memory |
 | ↑ | 0 | 1 | 0 | 0 | K - Kill->0 |
 | ↑ | 0 | 1 | 1 | 0 | K - Kill->0 |
 | ↑ | 1 | 0 | 0 | 1 | J - Jump->1 |
 | ↑ | 1 | 0 | 1 | 1 | J - Jump->1 |
 | ↑ | 1 | 1 | 0 | 1 | Toggle |
 | ↑ | 1 | 1 | 1 | 0 | Toggle |

 ![characteristic equation for JK](img/jk-char-eq.png)
 </br>
 | **CLK** | **T** | **Q(n)** | **Q(n+1)** | **Comment** |
 | :-: | :-: | :-: | :-: | :-: |
 | ↑ | 0 | 0 | 0 | Memory |
 | ↑ | 0 | 1 | 1 | Memory |
 | ↑ | 1 | 0 | 1 | Toggle |
 | ↑ | 1 | 1 | 0 | Toggle |

 ![characteristic equation for T](img/t-char-eq.png)
 </br>
### D & T Flip-flops

1. Screenshot with simulated time waveforms. Try to simulate both D- and T-type flip-flops in a single testbench with a maximum duration of 350 ns, including reset. Always display all inputs and outputs (display the inputs at the top of the image, the outputs below them) at the appropriate time scale!

   ![your figure]()

### JK Flip-flop

1. Listing of VHDL architecture for JK-type flip-flop. Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

```vhdl
architecture behavioral of jk_ff_rst is

    -- WRITE A SYNCHRONOUS PROCESS HERE

    -- Output ports are permanently connected to local signal
    q     <= sig_q;
    q_bar <= not sig_q;
end architecture behavioral;
```

### Shift register

1. Image of `top` level schematic of the 4-bit shift register. Use four D-type flip-flops and connect them properly. The image can be drawn on a computer or by hand. Always name all inputs, outputs, components and internal signals!

   ![your figure]()
