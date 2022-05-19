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
      <form className="m-4 flex" onSubmit={handleSubmit}>
        <input className="rounded-l-lg p-4 border-t mr-0 border-b border-l text-gray-800 border-gray-200 bg-white" placeholder="Ingredients: peanut butter,flour,sugar" type="text" value={formData.ingredients} onChange={(event) => setFormData({...formData, ingredients: event.target.value })} />
        <input className="px-8 rounded-r-lg bg-yellow-400  text-gray-800 font-bold p-4 uppercase border-yellow-500 border-t border-b border-r" type="submit" value="Gimme dinner ideas" />
      </form>

      {recipes.length > 0 &&
        recipes.map(({id, title, score, ingredients, image}) => (
          <>
            <div className="max-w-sm content-center flex flex-col justify-center mx-auto bg-white mt-[10vh] rounded-lg border border-gray-200 shadow-md dark:bg-gray-800 dark:border-gray-700">
              <div className="h-40 rounded-t-lg bg-contain bg-no-repeat bg-[url(https://www.linkpicture.com/q/Rectangle-6.png)]  flex flex-col justify-end pl-20 pr-20 pt-52  max-w-[24rem]">
                  <img className="w-25 h-25 rounded-full object-cover mb-2 z-10" src={image} alt="logo"/>
              </div>
              <div className="flex flex-col pl-10  pb-10">
                  <h1 className="text-3xl text-gray-900 font-semibold">{title}</h1>
                  <div className="mb-2 mt-2">
                      <h1 className="text-base text-gray-300 font-semibold">{score}</h1>
                  </div>
                  <div className="mb-2 mt-2">
                      <h1 className="text-base text-gray-300 font-semibold">Ingredients</h1>
                      {ingredients.map(({id, title}) => (
                        <div className="mt-2 flex items-center">
                          <h1 className="text-base text-gray-900 ml-5 font-semibold">{title}</h1>
                        </div>
                      ))}
                  </div>
              </div>
            </div>
          </>
        ))
      }
    </>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  const rootEl = document.getElementById('app')
  ReactDOM.createRoot(rootEl).render(<App />)
})
