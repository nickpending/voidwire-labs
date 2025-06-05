#!/bin/bash

echo "🚀 Setting up Hugo site with PaperMod theme..."

# Initialize git if not already done
if [ ! -d ".git" ]; then
    git init
fi

# Add PaperMod theme as submodule
if [ ! -d "themes/PaperMod" ]; then
    echo "📥 Adding PaperMod theme..."
    git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
else
    echo "✅ PaperMod theme already exists"
fi

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Run 'hugo server -D' to start development server"
echo "2. Visit http://localhost:1313 to see your site"
echo "3. Edit content in the content/ directory"
echo ""
echo "To deploy:"
echo "1. Push to GitHub"
echo "2. Connect to Netlify" 
echo "3. Done! (Netlify will auto-deploy)"
