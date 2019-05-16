window.app = {
  updateDailyUsage: ->
    ($ 'table').on 'change', 'input.formula_usage_per_day', (evt)->
      obj = evt.currentTarget
      formula_id = obj.id.split('_')[0]
      if $.isNumeric(obj.value)
        obj.parentNode.className = obj.parentNode.className.replace(' has-error', '')
        $.ajax { url: 'formulas/update_daily_usage', data: {id: formula_id, usage: obj.value }, type: 'put' }
      else
        obj.parentNode.className += ' has-error'

  initPremix: ->
    ($ 'form').on 'blur', '#premix_usage_bags',  ->
      usage = ($ this).val()
      target = ($ '#premix_target_bag_weight').val()
      premix_weight = ($ '#premix_premix_weight').val()
      ($ '#premix_balance_bag_weight').val((target - premix_weight/usage).toFixed(4))
      ($ '#print_premix').hide()

    ($ 'form').on 'blur', '#premix_target_bag_weight',  ->
      usage = ($ '#premix_usage_bags').val()
      target = ($ this).val()
      premix_weight = ($ '#premix_premix_weight').val()
      ($ '#premix_balance_bag_weight').val((target - premix_weight/usage).toFixed(4))
      ($ '#print_premix').hide()

    ($ 'form').on 'blur', '#premix_bags_of_premix', ->
      usage = ($ '#premix_usage_bags').val()
      bags = ($ this).val()
      premix_weight = ($ '#premix_premix_weight').val()
      ($ '#premix_total_premix_weight').val((bags * premix_weight/usage).toFixed(4))
      ($ '#print_premix').hide()

    ($ 'form').on 'blur', '.premix_usage', ->
      sum_premix_usage = 0
      ($ '.premix_usage').each (index, elm) ->
        val = ($ elm).val()
        sum_premix_usage = sum_premix_usage + +val
      ($ '#premix_premix_weight').val(sum_premix_usage.toFixed(4))
      ($ '#premix_target_bag_weight').blur()
      ($ '#premix_bags_of_premix').blur()

  unselectIngredient: ->
    ($ 'table#select_ingredients input[type=checkbox]').each (i, e) ->
      ($ e).prop('checked', false)

  reselectIngredient: (select_ingredients) ->
    select_ingredients.each (sni, sne) ->
      ($ "table#select_ingredients input[value=#{sne.value}]:checkbox").prop('checked', true)

  setFormIngredients: (select_ingredients, ingredient_container, bp_element_data, replace_string) ->
    select_ingredients.each (sni, sne) ->
      n = $(sne).data('name')
      cost = $(sne).data('cost')
      e = app.findFormIngredient(sne.value)
      if e
        ($ e).parent('tr.ingredient').show()
        ($ e).siblings('.destroy').attr('value', false)
      else
        id = (Math.random()*1000).toFixed(0) + new Date().getTime()
        html = $.parseHTML(bp_element_data.replace(new RegExp(replace_string, 'g'), id))
        ($ html).find('[name*=name]').attr('value', n)
        ($ html).find('[name*=cost]').attr('value', cost)
        ($ html).find('[name*=ingredient_id]').attr('value', sne.value)
        ($ ingredient_container).append(html)

  findFormIngredient: (ingredient_id) ->
    rtnval = null
    $('.ingredient_id').each (i, e) ->
      if e.value is ingredient_id
        rtnval = e
        return false
    return rtnval

  destroyFormIngredients: ->
    $('.ingredient_id ~ .destroy').each (i, e) ->
      ($ e).attr('value', true)
    $('.ingredient_id').parent('tr').each (i, e) ->
      ($ e).hide()

  initSelectIngredients: (ingredient_container, replace_string) ->
    bp_element = null
    bp_element_data = null
    form = null

    ($ '#cancel_selecting_ingredients').click (e) ->
      ($ '#scrollable_ingredients').hide()
      form.show()
      e.preventDefault()

    ($ '#select_ingredients_button').click (e) ->
      bp_element = ($ "#" + ($ this).attr('data-blueprint-id'))
      bp_element_data = ($ bp_element).attr('data-blueprint')
      form = ($ this).parents('form')
      # app.unselectIngredient()
      app.reselectIngredient $('.ingredient_id').parent(':visible').children('.ingredient_id')
      ($ '#scrollable_ingredients').show()
      form.hide()
      e.preventDefault()

    ($ '#done_selecting_ingredients').click (e) ->
      app.destroyFormIngredients()
      app.setFormIngredients $('table#select_ingredients input[type=checkbox]:checked'), ingredient_container, bp_element_data, replace_string
      form.show()
      ($ '#scrollable_ingredients').hide()
      e.preventDefault()

  unselectNutrient: ->
    ($ 'table#select_nutrients input[type=checkbox]').each (i, e) ->
      ($ e).prop('checked', false)

  reselectNutrient: (selected_nutrients) ->
    selected_nutrients.each (sni, sne) ->
      ($ "table#select_nutrients input[value=#{sne.value}]:checkbox").prop('checked', true)

  setFormNutrients: (selected_nutrients, nutrient_container, bp_element_data, replace_string) ->
    selected_nutrients.each (sni, sne) ->
      nu = $(sne).data('name-unit')
      e = app.findFormNutrient(sne.value)
      if e
        ($ e).parent('tr.nutrient').show()
        ($ e).siblings('.destroy').attr('value', false)
      else
        id = (Math.random()*1000).toFixed(0) + new Date().getTime()
        html = $.parseHTML(bp_element_data.replace(new RegExp(replace_string, 'g'), id))
        ($ html).find('[name*=name_unit]').attr('value', nu)
        ($ html).find('[name*=nutrient_id]').attr('value', sne.value)
        ($ nutrient_container).append(html)

  findFormNutrient: (nutrient_id) ->
    rtnval = null
    $('.nutrient_id').each (i, e) ->
      if e.value is nutrient_id
        rtnval = e
        return false
    return rtnval


  destroyFormNutrients: ->
    $('.nutrient_id ~ .destroy').each (i, e) ->
      ($ e).attr('value', true)
    $('.nutrient_id').parent('tr').each (i, e) ->
      ($ e).hide()

  initSelectNutrients: (nutrient_container, replace_string) ->
    bp_element = null
    bp_element_data = null
    form = null

    ($ '#cancel_selecting_nutrients').click (e) ->
      ($ '#scrollable_nutrients').hide()
      form.show()
      e.preventDefault()

    ($ '#select_nutrients_button').click (e) ->
      bp_element = ($ "#" + ($ this).attr('data-blueprint-id'))
      bp_element_data = ($ bp_element).attr('data-blueprint')
      form = ($ this).parents('form')
      # app.unselectNutrient()
      app.reselectNutrient $('.nutrient_id').parent(':visible').children('.nutrient_id')
      form.hide()
      ($ '#scrollable_nutrients').show()
      e.preventDefault()

    ($ '#done_selecting_nutrients').click (e) ->
      app.destroyFormNutrients()
      app.setFormNutrients $('table#select_nutrients input[type=checkbox]:checked'), nutrient_container, bp_element_data, replace_string
      ($ '#scrollable_nutrients').hide()
      form.show()
      e.preventDefault()
}
