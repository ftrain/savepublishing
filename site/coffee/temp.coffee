                    
                                                
        
        if el.nodeType is ELEMENT_NODE and el.isBlockLike()

                kids = el.childNodes
            nodes = (node for node in kids when not node.isBlockLike())
            prev=-1;
            texts = []
            
            for n in nodes
                do (n) ->
                    ntype = n.nodeType
                    if ntype is ELEMENT_NODE and n.isTextual()
                        text = n.getWrapper $(n).text()
                        texts.push(text)
                        $(n).remove()

                    else if ntype is TEXT_NODE
                        text = n.nodeValue.clean()
                        texts.push(text)
                        $(n).remove()

                    justChanged = prev isnt -1 and nodes[prev].type is TEXT_NODE
                    onlyOne = prev is -1 and nodes.length is 1
                    lastOne = prev is nodes.length - 1

                    if justChanged or lastOne or onlyOne
                        console.log justChanged, lastOne, onlyOne, ntype
                        text = texts.concatenate()

                        if lastOne or onlyOne
                            $(n).append($(text))
                        else
                            $(text).insertBefore($(n))

                        texts = []

                prev++
