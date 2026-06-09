#!/usr/bin/env bash

if command -v ollama >/dev/null 2>&1; then
  ollama pull qwen2.5-coder:3b
  ollama pull qwen2.5-coder:7b
  ollama pull qwen3:8b
  ollama pull gemma3:4b
  ollama pull llama3.2:3b 
else
