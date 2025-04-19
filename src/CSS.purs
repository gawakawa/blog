module CSS where

import Halogen.HTML as HH

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
    
    .yearly-goals {
      background-color: #f0f7ff;
      padding: 1.5rem;
      border-radius: 5px;
      margin-bottom: 2rem;
      border-left: 4px solid #0066cc;
    }
    
    .yearly-goals h3 {
      color: #0066cc;
      margin-bottom: 1rem;
      font-size: 1.3rem;
      text-align: center;
    }
    
    .yearly-goals h4 {
      color: #0055aa;
      margin: 0.8rem 0;
      font-size: 1.2rem;
      border-bottom: 1px solid #cce0ff;
      padding-bottom: 0.5rem;
    }
    
    .yearly-goals h5 {
      color: #0077cc;
      margin: 0.6rem 0;
      font-size: 1.1rem;
    }
    
    .goal-main {
      margin-top: 1rem;
    }
    
    .goal-medium {
      margin-left: 1rem;
      margin-bottom: 1.2rem;
      padding-left: 0.8rem;
      border-left: 2px solid #cce0ff;
    }
    
    .checkbox-container {
      margin-bottom: 0.8rem;
      position: relative;
      perspective: 1000px;
    }
    
    .checkbox-label {
      display: block;
      cursor: pointer;
      padding-left: 30px;
      position: relative;
      user-select: none;
      transition: all 0.3s ease;
      font-weight: 500;
    }
    
    .checkbox-label:hover {
      color: #0066cc;
    }
    
    .goal-checkbox {
      position: absolute;
      opacity: 0;
      cursor: pointer;
      height: 0;
      width: 0;
    }
    
    .checkbox-label:before {
      content: '';
      position: absolute;
      left: 0;
      top: 4px;
      width: 16px;
      height: 16px;
      border: 2px solid #0066cc;
      border-radius: 3px;
      background-color: white;
      transition: all 0.2s ease;
    }
    
    .checkbox-label:hover:before {
      border-color: #4a90e2;
    }
    
    .goal-checkbox:checked + .checkbox-label:before {
      background-color: #0066cc;
      border-color: #0066cc;
    }
    
    .goal-checkbox:checked + .checkbox-label:after {
      content: '';
      position: absolute;
      left: 5px;
      top: 7px;
      width: 4px;
      height: 8px;
      border: solid white;
      border-width: 0 2px 2px 0;
      transform: rotate(45deg);
    }
    
    .checkbox-container {
      position: relative;
    }
    
    .home-content {
      display: flex;
      flex-direction: column;
      gap: 2rem;
    }
    """ ]