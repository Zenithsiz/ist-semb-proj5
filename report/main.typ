#import "@preview/codly:1.2.0" as codly:
#import "util.typ" as util: code_figure, src_link


#set document(
	author: "Filipe Rodrigues",
	title: util.title,
	date: none
)
#set page(
	header: context {
		if counter(page).get().first() > 1 {
			image("images/tecnico-logo.png", height: 30pt)
		}
	},
	footer: context {
		if counter(page).get().first() > 1 {
			align(center, counter(page).display())
		}
	},
	margin: (x: 2cm, y: 30pt + 1.5cm)
)
#set text(
	font: "Libertinus Serif",
	lang: "en",
)
#set par(
	justify: true,
	leading: 0.65em,
)
#show link: underline

#show: codly.codly-init.with()

#include "cover.typ"
#pagebreak()

= Setup

For the setup, since our system doesn't have an internal DAC, we had to build an external one using the GPIO pins.

We decided on a 4-bit DAC using the following design, shown in @setup-circuit:

#figure(
	image("images/setup-circuit.svg", width: 80%),
	caption: [Setup circuit],
) <setup-circuit>

We only had 2 types of resistors available, 11 kΩ ±5% and 1.5 kΩ ±5%, in relatively limited quantity, so we had to be creative to implement the circuit.

#figure(
	image("images/setup.jpg", width: 80%),
	caption: [Setup],
) <setup>

= Experiment

#let main_src = read("src/main/main.c")

== Test 1

For this test, we simply ran the following `test1` function, shown in @test1-code:

#codly.codly(
	ranges: ((8, 25), (51, 51), (58, 58)),
	smart-skip: (first: false, last: false, rest: true),
	highlights: (
		(line: 58, start: 3, end: 4, fill: red),
	),
)
#code_figure(
	raw(main_src, lang: "c", block: true),
	caption: [Test 1 code]
) <test1-code>

After running it, we saw the following on the oscilloscope, in @test1-output:

#figure(
	image("images/test1.jpg", width: 80%),
	caption: [Test 1 output],
) <test1-output>

As we expected, we see a sawtooth wave, with a period of $160 "ms"$, a total of 16 steps, and thus each step takes $10 "ms"$.

== Test 2

For this test, we varied the timing from $10 "ms"$ to $20 "ms"$, and saw the following output on the oscilloscope, in @test2-output:

#figure(
	image("images/test2.jpg", width: 80%),
	caption: [Test 2 output],
) <test2-output>

As we expected, we see a period of $320 "ms"$.

== Test 3

For this test, we simply ran the following `test3` function, shown in @test3-code:

#codly.codly(
	ranges: ((27, 49), (51, 51), (59, 59)),
	smart-skip: (first: false, last: false, rest: true),
	highlights: (
		(line: 59, start: 3, end: 4, fill: red),
	),
)
#code_figure(
	raw(main_src, lang: "c", block: true),
	caption: [Test 3 code]
) <test3-code>

We ran it, but unfortunately, the photo of the oscilloscope was corrupted.

However, as we expected, we created a triangular wave, with a period of 6.4 seconds.

= Discussion Questions

== How does the delay affect the frequency of the waveform?

The delay approximately defines the frequency of the waveform inversely.

If the delay is $T$ time, and there are $N$ total steps for the waveform, the frequency of the wave will be $N / T$.

== What are the limitations of the DAC regarding speed and resolution?

The external DAC we create is extremely limited in resolution, since we only have 4 bits.

== How does the triangular waveform differ in terms of precision and smoothness compared to the ramp waveform?

We did not notice any appreciable difference in between the sawtooth and triangular waveforms.

#bibliography("bibliography.yaml", style: "ieee", full: true)
