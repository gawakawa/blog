module CSS where

import Halogen.HTML as HH

stylesheet :: forall r i. HH.HTML r i
stylesheet =
  HH.style_
    [ HH.text
        """
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
    
    .media-list {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
      grid-gap: 2rem;
    }
    
    .media-card {
      padding: 1.5rem;
      border: 1px solid #eee;
      border-radius: 5px;
      transition: all 0.3s;
      display: flex;
      flex-direction: column;
      height: 100%;
      background-color: white;
    }
    
    .media-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .media-header {
      display: flex;
      justify-content: space-between;
      margin-bottom: 0.8rem;
    }
    
    .media-type, .media-status, .media-priority {
      font-size: 0.8rem;
      padding: 0.2rem 0.6rem;
      border-radius: 3px;
      font-weight: bold;
    }
    
    .media-type {
      background-color: #e0f7fa;
      color: #006064;
    }
    
    .media-status {
      background-color: #e8f5e9;
      color: #1b5e20;
    }
    
    .media-priority {
      background-color: #fff3e0;
      color: #e65100;
    }
    
    .media-author {
      font-size: 0.9rem;
      color: #444;
      margin-bottom: 0.5rem;
    }
    
    .media-date {
      font-size: 0.9rem;
      color: #666;
      margin-bottom: 0.8rem;
    }
    
    .media-review-preview {
      margin-bottom: 1rem;
      font-style: italic;
      flex-grow: 1;
      color: #555;
      line-height: 1.5;
    }
    
    .media-no-review {
      margin-bottom: 1rem;
      color: #888;
      font-style: italic;
      flex-grow: 1;
    }
    
    .rating {
      margin-bottom: 1rem;
    }
    
    .star {
      color: #ddd;
      font-size: 1.2rem;
    }
    
    .star.filled {
      color: #ffc107;
    }
    
    .filters {
      display: flex;
      flex-wrap: wrap;
      gap: 1rem;
      margin-bottom: 1.5rem;
      padding: 1rem;
      background-color: #f9f9f9;
      border-radius: 5px;
    }
    
    .filter-group {
      display: flex;
      align-items: center;
      flex-wrap: wrap;
      gap: 0.5rem;
    }
    
    .filter-label {
      font-weight: 500;
      margin-right: 0.5rem;
    }
    
    .filter-button {
      padding: 0.3rem 0.8rem;
      background-color: #f0f0f0;
      border: 1px solid #ddd;
      border-radius: 3px;
      cursor: pointer;
      font-size: 0.9rem;
      transition: all 0.2s;
    }
    
    .filter-button:hover {
      background-color: #e0e0e0;
    }
    
    .filter-button.active {
      background-color: #0066cc;
      color: white;
      border-color: #0055aa;
    }
    
    .view-details, .read-more, .back-button {
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
    
    .media-full {
      padding: 1.5rem;
      background-color: white;
      border-radius: 5px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
    
    .media-badges {
      display: flex;
      flex-wrap: wrap;
      gap: 0.5rem;
      margin-bottom: 1rem;
    }
    
    .media-type-badge, .media-status-badge, .media-priority-badge {
      display: inline-block;
      padding: 0.3rem 0.8rem;
      border-radius: 3px;
      font-weight: bold;
      font-size: 0.9rem;
    }
    
    .media-type-badge {
      background-color: #e0f7fa;
      color: #006064;
    }
    
    .media-status-badge {
      background-color: #e8f5e9;
      color: #1b5e20;
    }
    
    .media-priority-badge {
      background-color: #fff3e0;
      color: #e65100;
    }
    
    .media-categories {
      display: flex;
      flex-wrap: wrap;
      gap: 0.5rem;
      margin-bottom: 1rem;
    }
    
    .category-tag {
      display: inline-block;
      padding: 0.2rem 0.6rem;
      background-color: #f1f8e9;
      color: #558b2f;
      border-radius: 16px;
      font-size: 0.8rem;
      cursor: pointer;
      transition: all 0.2s;
    }
    
    .category-tag:hover {
      background-color: #dcedc8;
      transform: translateY(-2px);
    }
    
    .media-dates {
      display: flex;
      gap: 1rem;
      flex-wrap: wrap;
      margin-bottom: 1rem;
      font-size: 0.9rem;
      color: #666;
    }
    
    .media-categories-section {
      margin: 1.5rem 0;
    }
    
    .media-categories-section h3 {
      margin-bottom: 0.5rem;
      font-size: 1.1rem;
      color: #333;
    }
    
    .media-review {
      margin: 1.5rem 0;
      padding: 1.5rem;
      background-color: #f9f9f9;
      border-radius: 5px;
      line-height: 1.8;
    }
    
    .media-review h3 {
      margin-bottom: 1rem;
      color: #333;
      font-size: 1.2rem;
    }
    
    .no-review {
      font-style: italic;
      color: #888;
    }
    
    .media-link a {
      color: #0066cc;
      text-decoration: none;
      display: inline-block;
      margin-bottom: 1rem;
    }
    
    .media-link a:hover {
      text-decoration: underline;
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
    """
    ]