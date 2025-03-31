module CSS where

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

stylesheet :: forall r i. HH.HTML r i
stylesheet = 
  HH.style_ 
    [ HH.text """
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    
    body {
      font-family: 'Helvetica Neue', Arial, sans-serif;
      line-height: 1.6;
      color: #333;
      background-color: #f5f5f5;
    }
    
    .blog-container {
      max-width: 800px;
      margin: 0 auto;
      padding: 2rem;
      background-color: white;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    
    header {
      margin-bottom: 2rem;
      padding-bottom: 1rem;
      border-bottom: 1px solid #eee;
      text-align: center;
    }
    
    h1 {
      font-size: 2.5rem;
      color: #333;
    }
    
    .subtitle {
      font-size: 1.1rem;
      color: #666;
    }
    
    .posts-list {
      display: grid;
      grid-gap: 2rem;
    }
    
    .post-preview {
      padding: 1.5rem;
      border: 1px solid #eee;
      border-radius: 5px;
      transition: all 0.3s;
    }
    
    .post-preview:hover {
      transform: translateY(-3px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .post-date {
      font-size: 0.9rem;
      color: #666;
      margin-bottom: 0.5rem;
    }
    
    .post-excerpt {
      margin-bottom: 1rem;
    }
    
    .read-more, .back-button {
      display: inline-block;
      padding: 0.5rem 1rem;
      background-color: #0066cc;
      color: white;
      border: none;
      border-radius: 3px;
      cursor: pointer;
      font-size: 0.9rem;
      transition: background-color 0.3s;
    }
    
    .read-more:hover, .back-button:hover {
      background-color: #0055aa;
    }
    
    .post-full {
      padding: 1rem;
    }
    
    .post-content {
      margin: 1.5rem 0;
      line-height: 1.8;
    }
    
    footer {
      margin-top: 2rem;
      padding-top: 1rem;
      border-top: 1px solid #eee;
      text-align: center;
      font-size: 0.9rem;
      color: #666;
    }
    """ ]