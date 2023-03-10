-- table sum, calculates the sum of all values in a table 
function table.sum(t)
    local sum = 0
    for i, v in ipairs(t) do
        if type(v) == 'number' then
            sum = sum + v
        end
    end
    return sum
end

-- table.filter, filters a table based on a statement
function table.filter(t, filterFunc)
    local filtered = {}
    for i, v in ipairs(t) do
        if filterFunc(v) then
            table.insert(filtered, v)
        end
    end
    return filtered
end

-- table.map, maps a table based on a statement

function table.map(t, mapFunc)
    local mapped = {}
    for i, v in ipairs(t) do
        table.insert(mapped, mapFunc(v))
    end
    return mapped
end

-- table.reduce, reduces a table based on a statement
function table.reduce(t, reduceFunc, initialValue)
    local reduced = initialValue or t[1]
    local startIndex = initialValue and 1 or 2
    for i = startIndex, #t do
        reduced = reduceFunc(reduced, t[i])
    end
    return reduced
end

-- table.shuffle, shuffles a table

function table.shuffle(t)
    local shuffled = {}
    for i, v in ipairs(t) do
        local index = math.random(1, #shuffled + 1)
        table.insert(shuffled, index, v)
    end
    return shuffled
end

-- table.contains, checks if a table contains a value
function table.contains(t, value)
    for i, v in ipairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

-- table.copy copies a table

function table.copy(t)
    local copy = {}
    for i, v in ipairs(t) do
        if type(v) == 'table' then
            copy[i] = table.copy(v)
        else
            copy[i] = v
        end
    end
    return copy
end

-- table.merge, merges two tables

function table.merge(t1, t2)
    local merged = {}
    for i, v in ipairs(t1) do
        table.insert(merged, v)
    end
    for i, v in ipairs(t2) do
        table.insert(merged, v)
    end
    return merged
end

-- table.print, prints a table

function table.print(t)
    for i, v in ipairs(t) do
        if type(v) == 'table' then
            table.print(v)
        else
            print(v)
        end
    end
end
-- table.set, sets a value in a table
function table.set(t, key, value)
    t[key] = value
end
-- table.get, gets a value in a table
function table.get(t, key)
    return t[key]
end

--table.all and table.any, checks if all or any values in a table match a predicate function respectively
function table.all(t, predicate)
    for _, v in ipairs(t) do
        if not predicate(v) then
            return false
        end
    end
    return true
end

function table.any(t, predicate)
    for _, v in ipairs(t) do
        if predicate(v) then
            return true
        end
    end
    return false
end

-- table.flatten, flattens a table
function table.flatten(t)
    local flattened = {}
    for i, v in ipairs(t) do
        if type(v) == 'table' then
            local flattenedTable = table.flatten(v)
            for j, w in ipairs(flattenedTable) do
                table.insert(flattened, w)
            end
        else
            table.insert(flattened, v)
        end
    end
    return flattened
end

-- table.flatmap, maps a table and flattens the result
function table.flatmap(t, mapFunc)
    local mapped = table.map(t, mapFunc)
    return table.flatten(mapped)
end

--table.group, method groups the elements of the calling array according to the string values returned by a provided testing function.
function table.group(t, groupFunc)
    local groups = {}
    for i, v in ipairs(t) do
        local group = groupFunc(v)
        if not groups[group] then
            groups[group] = {}
        end
        table.insert(groups[group], v)
    end
    return groups
end

--table.localestring method returns a string representing the elements of the table. The elements are converted to strings using tostring, and the strings are seperated by the given seperator string.
function table.localestring(t, seperator)
    local str = ''
    for i, v in ipairs(t) do
        str = str .. tostring(v)
        if i ~= #t then
            str = str .. seperator
        end
    end
    return str
end

-- table.indexof, returns the index of a value in a table or nil if the value is not found
function table.indexof(t, value)
    for i, v in ipairs(t) do
        if v == value then
            return i
        end
    end
    return nil
end

-- table.removevalues removes values from a table
function table.removevalues(t, values)
    for i, v in ipairs(values) do
        local index = table.indexof(t, v)
        if index then
            table.remove(t, index)
        end
    end
end

-- table.foreach, javascript style foreach function

function table.foreach(t, callback)
    for i, v in ipairs(t) do
        callback(v, i)
    end
end

-- table.splice javascript style splice function

function table.splice(t, start, deleteCount, ...)
    local deleted = {}
    local args = {...}
    local argCounts = #args
    local itemCount = #t
    local actualStart = start < 0 and math.max(itemCount + start, 0) or math.min(start, itemCount)
    local actualDeleteCount = math.min(math.max(deleteCount, 0), itemCount - actualStart)
    local k = 0
    for i = actualStart, actualStart + actualDeleteCount - 1 do
        k = k + 1
        deleted[k] = t[i + 1]
    end
    local itemCount = itemCount - actualDeleteCount
    if argCounts < actualDeleteCount then
        k = actualStart
        while k < itemCount do
            t[k + 1] = t[k + actualDeleteCount + 1]
            k = k + 1
        end
        for i = 1, actualDeleteCount - argCounts do
            t[itemCount + i] = nil
        end
    elseif argCounts > actualDeleteCount then
        k = itemCount - actualDeleteCount
        while k > actualStart do
            t[k + actualDeleteCount] = t[k]
            k = k - 1
        end
    end
    for i = 1, argCounts do
        t[actualStart + i] = args[i]
    end
    return deleted
end

--table.lastindexof, returns the last index of a value in a table or nil if the value is not found
function table.lastindexof(t, value)
    for i = #t, 1, -1 do
        if t[i] == value then
            return i
        end
    end
    return nil
end

-- table.reverse, reverses a table
function table.reverse(t)
    local reversed = {}
    for i = #t, 1, -1 do
        table.insert(reversed, t[i])
    end
    return reversed
end

-- table.max and table.min, returns the maximum and minimum values in a table respectively
function table.max(t)
    local max = t[1]
    for i = 2, #t do
        if t[i] > max then
            max = t[i]
        end
    end
    return max
end

function table.min(t)
    local min = t[1]
    for i = 2, #t do
        if t[i] < min then
            min = t[i]
        end
    end
    return min
end

--footnote table.max alike function already exists in the standard library, but it is not documented. It is called table.maxn. It is not recommended to use it, because it is not documented and it is not guaranteed to work in the future.
--(what I mean by not documented is that it is listed in library but not have any example of how to use it.)


