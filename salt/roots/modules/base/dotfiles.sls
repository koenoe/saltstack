bash_profile:
  file.managed:
    - name: /home/koen/.bash_profile
    - contents: |
         for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
           [ -r "$file" ] && [ -f "$file" ] && source "$file";
         done;
         unset file;

bash_prompt:
  cmd.run:
    - name: 'curl -L https://github.com/koenoe/dotfiles/raw/master/.bash_prompt > /home/koen/.bash_prompt'
