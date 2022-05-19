// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import React, { useState } from 'react'
import * as ReactDOM from 'react-dom/client'

const App = () => {
  const handleSubmit = async (event) => {
    event.preventDefault()

    const ingredients = formData.ingredients.split(",").map(ingredient => ["ingredients[]", ingredient])
    const searchParams = new URLSearchParams(ingredients)

    try {
      const response = await fetch("/recipes/search?" + searchParams)

      if (!response.ok) {
        throw new Error(response.error)
      }

      const data = await response.json()

      setRecipes(data)
    } catch (error) {
      alert(error)
    }
  }

  const [formData, setFormData] = useState({ ingredients: "" })
  const [recipes, setRecipes] = useState([])

  return (
    <>
      <form onSubmit={handleSubmit}>
        <label>
          In my fridge I have:
        </label>
        <input type="text" value={formData.ingredients} onChange={(event) => setFormData({...formData, ingredients: event.target.value })} />
        <input type="submit" value="Gimme dinner ideas" />
      </form>

      {recipes.length > 0 &&
        recipes.map(({id, title, score, ingredients}) => (
          <div key={id}>
            <h3>{title}</h3>
            <p><strong>{score}</strong></p>
            <ul>
              {ingredients.map(({id, title}) => (<li key={id}>{title}</li>))}
            </ul>
          </div>
        ))
      }
    </>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  const rootEl = document.getElementById('app')
  ReactDOM.createRoot(rootEl).render(<App />)
})
