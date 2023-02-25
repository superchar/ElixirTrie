defmodule TrieNode do
  defstruct key: nil, children: %{}, is_completed: false
end

defmodule Trie do

  def put(node, word) do
    put_recursive(node, word |> String.to_charlist)
  end

  def contains(node, word) do
    case node |> find_node(word |> String.to_charlist) do
      %TrieNode{is_completed: is_completed} -> is_completed
      nil -> false
    end
  end

  def contains_prefix(node, word) do
    case node |> find_node(word |> String.to_charlist) do
      %TrieNode{} -> true
      nil -> false
    end
  end

  defp put_recursive(node, [head | tail]) do
    child = node.children |> Map.put_new(head, %TrieNode{key: head}) |> Map.get(head)
    %TrieNode {node| children: node.children |> Map.put(head, put_recursive(child, tail))}
  end

  defp put_recursive(node, []) do
    %TrieNode{node | is_completed: true}
  end

  defp find_node(node,  [head | tail]) do
    case node.children |> Map.fetch(head) do
      {:ok, child} -> find_node(child, tail)
      :error -> nil
    end
  end

  defp find_node(node, []) do
    node
  end

end


