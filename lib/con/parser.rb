# Author:		Chris Wailes <chris.wailes@gmail.com>
# Project: 	Con
# Date:		2014/10/02
# Description:	This file contains a parser for a version of Scheme.

############
# Requires #
############

# Ruby Language Toolkit
require 'rltk/parser'

# Con
require 'con/symbol_table'

#######################
# Classes and Modules #
#######################

module Con
	# A parser for the language accepted by Con.
	class Parser < RLTK::Parser

		p(:e) do
			c('SYM')   { |n| @st[n] }
			c('INT')   { |n| Con::Int.new(n) }
			c('FLOAT') { |n| Con::Float.new(n) }

			c('LPAREN LAMBDA LPAREN .param_syms RPAREN .e RPAREN') { |params, body| Lambda.new(params, body) }

			c('LPAREN .e .e* RPAREN') { |rator, rands| Application.new(rator, rands) }
		end

		p(:param_syms) do
			c('')                { [] }
			c(:param_syms_prime) { |lst| lst }
		end

		p(:param_syms_prime) do
			c('.SYM COLON .type')                   { |s, t|           [@st.declare(s, t)] }
			c('.param_syms_prime .SYM COLON .type') { |lst, s, t| lst << @st.declare(s, t) }
		end

		p(:type) do
			c(:TINT)   { |_| :int   }
			c(:TFLOAT) { |_| :float }
		end

		token_hook(:LAMBDA) {@st.new_frame}

		class Environment < Environment
			def initialize
				@errors = Array.new
				@st     = SymbolTable.new
			end
		end

		finalize explain: 'con.automata'
	end
end
