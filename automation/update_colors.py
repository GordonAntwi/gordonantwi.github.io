#!/usr/bin/env python3
"""
Color Theme Update Script
Updates website from blue-gray theme to vibrant primary colors (blue-red-yellow)
Run: py -3 automation/update_colors.py
"""

import os
import re

# Define color replacements
color_replacements = {
    # Header/Navigation
    'bg-gray-900': 'bg-gradient-to-r from-blue-700 via-blue-600 to-indigo-600',
    'text-blue-400': 'text-yellow-300',
    'text-gray-300': 'text-yellow-100',
    'hover:text-blue-400': 'hover:text-yellow-300',
    'hover:bg-gray-700': 'hover:bg-blue-700',
    'text-blue-300': 'text-yellow-200',
    'bg-gray-800': 'bg-gradient-to-r from-blue-700 to-purple-700',
    'border-blue-600': 'border-red-500',
    'border-blue-500': 'border-red-500',
    
    # Hero section
    'bg-blue-600': 'bg-gradient-to-r from-red-500 via-yellow-400 to-yellow-300',
    'hover:bg-blue-700': 'hover:shadow-xl',
    
    # Service cards  
    'border-t-4 border-blue-600': 'border-t-4 border-red-500',
    'text-blue-600 mb-4': 'text-gradient bg-gradient-to-r from-blue-600 to-red-500 bg-clip-text text-transparent mb-4 font-bold',
    
    # Sections
    'id="clients" class="section-padding bg-gray-900': 'id="clients" class="section-padding bg-gradient-to-r from-blue-800 via-indigo-700 to-blue-900',
    'bg-gray-800 rounded-2xl shadow-2xl border-b-4 border-blue-600': 'bg-gradient-to-br from-blue-700 to-purple-700 rounded-2xl shadow-2xl border-b-4 border-yellow-400 hover:border-red-400 transition',
    
    # Buttons
    'bg-blue-600 text-white': 'bg-gradient-to-r from-red-500 to-yellow-400 text-blue-900 font-bold',
    
    # Highlights
    'bg-blue-50': 'bg-gradient-to-r from-blue-50 to-yellow-50',
    'border-l-4 border-blue-600': 'border-l-4 border-red-500',
}

def update_html_colors(filepath):
    """Update colors in HTML file"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # Apply replacements
        for old_color, new_color in color_replacements.items():
            content = content.replace(old_color, new_color)
        
        if content != original_content:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"✅ Updated: {filepath}")
            return True
        else:
            print(f"⏭️  No changes: {filepath}")
            return False
    except Exception as e:
        print(f"❌ Error updating {filepath}: {e}")
        return False

def main():
    """Main function"""
    print("🎨 Updating Website Color Theme...")
    print("=" * 50)
    
    # Get all HTML files
    html_files = []
    for file in os.listdir('.'):
        if file.endswith('.html'):
            html_files.append(file)
    
    updated_count = 0
    for html_file in sorted(html_files):
        if update_html_colors(html_file):
            updated_count += 1
    
    print("=" * 50)
    print(f"✨ Done! Updated {updated_count} files")
    print("\nNew Color Scheme:")
    print("  🔵 Primary Blue: #1E40AF - #3B82F6")
    print("  🔴 Red Accent: #DC2626 - #EF4444")
    print("  🟡 Yellow Accent: #F59E0B - #FBBF24")
    print("  ✨ Gradients: Reflective & beautiful blends")

if __name__ == "__main__":
    main()
