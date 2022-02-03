var documenterSearchIndex = {"docs":
[{"location":"frct/#Fractional-Cosine-Transform","page":"Fractional Cosine Transform","title":"Fractional Cosine Transform","text":"","category":"section"},{"location":"frct/","page":"Fractional Cosine Transform","title":"Fractional Cosine Transform","text":"FractionalTransforms.frct","category":"page"},{"location":"frct/#FractionalTransforms.frct","page":"Fractional Cosine Transform","title":"FractionalTransforms.frct","text":"frct(signal, α, p)\n\nComputing the α order fractional cosine transform of the input signal.\n\nExample\n\njulia> frct([1,2,3], 0.5, 2)\n3-element Vector{ComplexF64}:\n1.707106781186547 + 0.9874368670764581im\n1.5606601717798205 - 1.3964466094067267im\n-0.3535533905932727 - 0.6982233047033652im\n\nReferences\n\n@article{article,\nauthor = {Pei, Soo-Chang and Yeh, Min-Hung},\nyear = {2001},\nmonth = {07},\npages = {1198 - 1207},\ntitle = {The discrete fractional cosine and sine transforms},\nvolume = {49},\njournal = {Signal Processing, IEEE Transactions on},\ndoi = {10.1109/78.923302}\n}\n\n\n\n\n\n","category":"function"},{"location":"frft/#Fractional-Fourier-Transform","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"","category":"section"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"Pages = [\"frft.md\"]","category":"page"},{"location":"frft/#Definition","page":"Fractional Fourier Transform","title":"Definition","text":"","category":"section"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"While we are already familiar with the Fourier transform, which is defined by the integral of the product of the original function and a kernel function e^-2pi ixxi:","category":"page"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"hatf(xi)=mathcalFf(x)=int_-infty^infty f(x)e^-2pi ixxidx","category":"page"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"The Fractional Fourier transform has the similar definition:","category":"page"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"hatf(xi)=mathcalF^alphaf(x)=int_-infty^infty K(xix)f(x)dx","category":"page"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"K(xix)=A_phi expipi(x^2cotphi-2xxicscphi+xi^2cotphi)","category":"page"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"A_phi=fracexp(-ipi mathrmsgn(sinphi)4+iphi2)sinphi^12","category":"page"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"phi=fracalphapi2","category":"page"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"To compute the α-order Fractional Fourier transform of a signal, you can directly compute using frft function: ","category":"page"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"FractionalTransforms.frft","category":"page"},{"location":"frft/#FractionalTransforms.frft","page":"Fractional Fourier Transform","title":"FractionalTransforms.frft","text":"frft(signal, α)\n\nBy entering the signal and the order, we can obtain the Fractional Fourier transform value.\n\nExample\n\njulia> frft([1,2,3], 0.5)\n0.10046461358821344 - 0.25940948097727745im\n3.0746001042331557 + 0.19934938154063286im\n1.3156643288728376 - 0.9364535656119107im\n\n\n\n\n\n","category":"function"},{"location":"frft/#Features","page":"Fractional Fourier Transform","title":"Features","text":"","category":"section"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"The fractional Fourier transform algorithm is O(Nlog N) time complexity algorithm.","category":"page"},{"location":"frft/#Relationship-with-FRST-and-FRCT","page":"Fractional Fourier Transform","title":"Relationship with FRST and FRCT","text":"","category":"section"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"The FRFT can be computed by a smaller transform kernel with the help of the FRCT or the DFRST for the even or odd signal.","category":"page"},{"location":"frft/#Algorithm-details","page":"Fractional Fourier Transform","title":"Algorithm details","text":"","category":"section"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"The numerical algorithm can be treated as as follows:","category":"page"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"The definition of Fractional Fourier Transform being interpolated using Shannon interpolation, after limit the range, the formulation can be recognized as the convolution of the kernel function and the chirp-modulated function. Then we can use FFT to compute the convolution in O(N log N) time. Finally, process the above output using the chirp modulation.","category":"page"},{"location":"frft/#Acknowledge:","page":"Fractional Fourier Transform","title":"Acknowledge:","text":"","category":"section"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"The Fractional Fourier Transform algorithm is taken from Digital computation of the fractional Fourier transform by H.M. Ozaktas; O. Arikan; M.A. Kutay; G. Bozdagt and Jeffrey C. O'Neill for what he has done in DiscreteTFDs.","category":"page"},{"location":"frft/","page":"Fractional Fourier Transform","title":"Fractional Fourier Transform","text":"tip: Value of α\nIn FractionalTransforms.jl, α is processed as order, while in some books or papers, α would mean angle, which is order*π/2","category":"page"},{"location":"frst/#Fractional-Sine-Transform","page":"Fractional Sine Transform","title":"Fractional Sine Transform","text":"","category":"section"},{"location":"frst/","page":"Fractional Sine Transform","title":"Fractional Sine Transform","text":"FractionalTransforms.frst","category":"page"},{"location":"frst/#FractionalTransforms.frst","page":"Fractional Sine Transform","title":"FractionalTransforms.frst","text":"frst(signal, α, p)\n\nComputing the α order fractional sine transform of the input signal.\n\nExample\n\njulia> frst([1,2,3], 0.5, 2)\n3-element Vector{ComplexF64}:\n1.707106781186548 + 1.207106781186547im\n1.9999999999999998 - 1.7071067811865481im\n-1.1213203435596437 - 1.2071067811865468im\n\nReferences\n\n@article{article,\nauthor = {Pei, Soo-Chang and Yeh, Min-Hung},\nyear = {2001},\nmonth = {07},\npages = {1198 - 1207},\ntitle = {The discrete fractional cosine and sine transforms},\nvolume = {49},\njournal = {Signal Processing, IEEE Transactions on},\ndoi = {10.1109/78.923302}\n}\n\n\n\n\n\n","category":"function"},{"location":"frst/#Property","page":"Fractional Sine Transform","title":"Property","text":"","category":"section"},{"location":"frst/","page":"Fractional Sine Transform","title":"Fractional Sine Transform","text":"<!–comment @ARTICLE{923302,  author={Soo-Chang Pei and Min-Hung Yeh},  journal={IEEE Transactions on Signal Processing},   title={The discrete fractional cosine and sine transforms},   year={2001},  volume={49},  number={6},  pages={1198-1207},  doi={10.1109/78.923302}} –>","category":"page"},{"location":"frst/","page":"Fractional Sine Transform","title":"Fractional Sine Transform","text":"Unitarity\nAngle additivity\nPeriodicity\nSymmetric","category":"page"},{"location":"#FractionalTransforms.jl","page":"Home","title":"FractionalTransforms.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Hello there👋!","category":"page"},{"location":"","page":"Home","title":"Home","text":"FractionalTransforms.jl is a Julia package aiming at providing supports for computing fractional transforms.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"To install FractionalTransforms.jl, please open Julia REPL and press] key to use package mode and then type the following command:","category":"page"},{"location":"","page":"Home","title":"Home","text":"Pkg> add FractionalTransforms","category":"page"},{"location":"","page":"Home","title":"Home","text":"Or if you want to experience the latest version of FractionalTransforms.jl:","category":"page"},{"location":"","page":"Home","title":"Home","text":"Pkg> add FractionalTransforms#master","category":"page"},{"location":"#Plans","page":"Home","title":"Plans","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Add more examples relating to signal processing, image processing etc.\nCover more algorithms, including Fractional Hadamard Transform...","category":"page"},{"location":"#Acknowledgements","page":"Home","title":"Acknowledgements","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"I would like to express gratitude to ","category":"page"},{"location":"","page":"Home","title":"Home","text":"Jeffrey C. O'Neill for what he has done in DiscreteTFDs.\nDigital computation of the fractional Fourier transform by H.M. Ozaktas; O. Arikan; M.A. Kutay; G. Bozdagt\nThe discrete fractional cosine and sine transforms by Pei, Soo-Chang and Yeh, Min-Hung.","category":"page"},{"location":"","page":"Home","title":"Home","text":"FractionalTransforms.jl is built upon the hard work of many scientific researchers, I sincerely appreciate what they have done to help the development of science and technology.","category":"page"},{"location":"","page":"Home","title":"Home","text":"info: WIP\nFractionalTransforms.jl is under heavy construction, some API or docs might change a lot.","category":"page"}]
}
