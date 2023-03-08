# required
mv ~/.config/nvim ~/.config/nvim."$2"

# optional but recommended
mv ~/.local/share/nvim ~/.local/share/nvim."$2"
mv ~/.local/state/nvim ~/.local/state/nvim."$2"
mv ~/.cache/nvim ~/.cache/nvim."$2"


# required
mv ~/.config/nvim."$1" ~/.config/nvim

# optional but recommended
mv ~/.local/share/nvim."$1" ~/.local/share/nvim
mv ~/.local/state/nvim."$1" ~/.local/state/nvim
mv ~/.cache/nvim."$1" ~/.cache/nvim
