#!/usr/bin/env bash

uv tool install conan
uv tool install platformio

if command -v ollama >/dev/null 2>&1; then
  ollama pull qwen2.5-coder:3b
  ollama pull qwen2.5-coder:7b
  ollama pull gemma3:4b
  ollama pull llama3.2:3b 
else
